import cv2 as cv
import mediapipe as mp
import time 
import numpy as np

def extract_index_nparray(nparray):
    index = None
    for num in nparray[0]:
        index = num
        break
    return index

cap = cv.VideoCapture(0)

mpFaceMesh = mp.solutions.face_mesh
faceMesh = mpFaceMesh.FaceMesh(max_num_faces=2)

while True:
    success, img = cap.read()
    imgRGB = cv.cvtColor(img, cv.COLOR_BGR2RGB)
    results = faceMesh.process(imgRGB)

    result = img
    cropped_triangle1 = img
    cropped_triangle2 = img
    warped_triangle = img
    img_new_face = img
    img_head_noface = img
    img2 = img
    img2_gray = cv.cvtColor(img2, cv.COLOR_BGR2GRAY)


    if results.multi_face_landmarks:
         
        if len(results.multi_face_landmarks)==2:
            height, width, _ = img.shape

            facelandmarks0 = []
            facelandmarks1 = []
            for i in range(0, 150):
                pt0 = results.multi_face_landmarks[0].landmark[i]
                pt1 = results.multi_face_landmarks[1].landmark[i]
                x0 = int(pt0.x * width)
                x1 = int(pt1.x * width)
                y0 = int(pt0.y * height)
                y1 = int(pt1.y * height)
                facelandmarks0.append([x0, y0])
                facelandmarks1.append([x1, y1])

            landmarks0 = np.array(facelandmarks0, np.int32)
            landmarks1 = np.array(facelandmarks1, np.int32)

            convexhull0 = cv.convexHull(landmarks0)
            convexhull1 = cv.convexHull(landmarks1)

            rect0 = cv.boundingRect(convexhull0)
            rect1 = cv.boundingRect(convexhull1)

            subdiv0 = cv.Subdiv2D(rect0)
            subdiv0.insert(facelandmarks0)
            triangles0 = subdiv0.getTriangleList()
            triangles0 = np.array(triangles0, dtype=np.int32)

            subdiv1 = cv.Subdiv2D(rect1)
            subdiv1.insert(facelandmarks1)
            triangles1 = subdiv1.getTriangleList()
            triangles1 = np.array(triangles1, dtype=np.int32)

            triangles_list = [triangles0,triangles1]

            indexes_triangles0 = []
            indexes_triangles1 = []
            indexes_triangles_list = [indexes_triangles0,indexes_triangles1]

            facelandmarks_list = [facelandmarks0,facelandmarks1]

            for triangles,indexes_triangles in zip(triangles_list, indexes_triangles_list):
                for t in triangles:
                    pt1 = (t[0], t[1])
                    pt2 = (t[2], t[3])
                    pt3 = (t[4], t[5])
                    index_pt1 = np.where((landmarks0 == pt1).all(axis=1))
                    index_pt1 = extract_index_nparray(index_pt1)
                    index_pt2 = np.where((landmarks0 == pt2).all(axis=1))
                    index_pt2 = extract_index_nparray(index_pt2)
                    index_pt3 = np.where((landmarks0 == pt3).all(axis=1))
                    index_pt3 = extract_index_nparray(index_pt3)
                    if index_pt1 is not None and index_pt2 is not None and index_pt3 is not None:
                        triangle = [index_pt1, index_pt2, index_pt3]
                        indexes_triangles.append(triangle)
                    # cv.line(img, pt1, pt2, (0, 0, 255), 2)
                    # cv.line(img, pt2, pt3, (0, 0, 255), 2)
                    # cv.line(img, pt1, pt3, (0, 0, 255), 2)

            for triangle_index in indexes_triangles:
                # Triangulation of the first face
                tr1_pt1 = landmarks0[triangle_index[0]]
                tr1_pt2 = landmarks0[triangle_index[1]]
                tr1_pt3 = landmarks0[triangle_index[2]]
                triangle1 = np.array([tr1_pt1, tr1_pt2, tr1_pt3], np.int32)
                rect1 = cv.boundingRect(triangle1)
                (x, y, w, h) = rect1
                cropped_triangle = img[y: y + h, x: x + w]
                cropped_tr1_mask = np.zeros((h, w), np.uint8)
                points = np.array([
                    [tr1_pt1[0] - x, tr1_pt1[1] - y],
                    [tr1_pt2[0] - x, tr1_pt2[1] - y],
                    [tr1_pt3[0] - x, tr1_pt3[1] - y]],
                    np.int32)
                cv.fillConvexPoly(cropped_tr1_mask, points, 255)
                cropped_triangle = cv.bitwise_and(cropped_triangle, cropped_triangle,mask=cropped_tr1_mask)
                cv.line(img, tr1_pt1, tr1_pt2, (0, 0, 255), 2)
                cv.line(img, tr1_pt3, tr1_pt2, (0, 0, 255), 2)
                cv.line(img, tr1_pt1, tr1_pt3, (0, 0, 255), 2)

                # Triangulation of second face
                tr2_pt1 = landmarks1[triangle_index[0]]
                tr2_pt2 = landmarks1[triangle_index[1]]
                tr2_pt3 = landmarks1[triangle_index[2]]
                triangle2 = np.array([tr2_pt1, tr2_pt2, tr2_pt3], np.int32)
                rect2 = cv.boundingRect(triangle2)
                (x, y, w, h) = rect2
                cropped_triangle2 = img[y: y + h, x: x + w]
                cropped_tr2_mask = np.zeros((h, w), np.uint8)
                points2 = np.array([
                    [tr2_pt1[0] - x, tr2_pt1[1] - y],
                    [tr2_pt2[0] - x, tr2_pt2[1] - y],
                    [tr2_pt3[0] - x, tr2_pt3[1] - y]]
                    , np.int32)
                cv.fillConvexPoly(cropped_tr2_mask, points2, 255)
                cropped_triangle2 = cv.bitwise_and(cropped_triangle2, cropped_triangle2,mask=cropped_tr2_mask)
                cv.line(img2, tr2_pt1, tr2_pt2, (0, 0, 255), 2)
                cv.line(img2, tr2_pt3, tr2_pt2, (0, 0, 255), 2)
                cv.line(img2, tr2_pt1, tr2_pt3, (0, 0, 255), 2)

                points = np.float32(points)
                points2 = np.float32(points2)
                M = cv.getAffineTransform(points, points2)

                warped_triangle = cv.warpAffine(cropped_triangle, M, (w, h))

                img2_new_face = np.zeros_like(img2)

                # Reconstructing destination face
                img2_new_face_rect_area = img2_new_face[y: y + h, x: x + w]
                img2_new_face_rect_area = cv.add(img2_new_face_rect_area, warped_triangle)
                img2_new_face[y: y + h, x: x + w] = img2_new_face_rect_area
                # Face swapped (putting 1st face into 2nd face)
                img2_face_mask = np.zeros_like(img2_gray)
                img2_head_mask = cv.fillConvexPoly(img2_face_mask, convexhull1, 255)
                img2_face_mask = cv.bitwise_not(img2_head_mask)
                img2_head_noface = cv.bitwise_and(img2, img2, mask=img2_face_mask)
                result = cv.add(img_head_noface, img_new_face)

                
            # mask0 = np.zeros((height, width), np.uint8)
            # mask1 = np.zeros((height, width), np.uint8)
            # cv.fillConvexPoly(mask0, convexhull0, 255)
            # cv.fillConvexPoly(mask1, convexhull1, 255)
            # face_extracted0 = cv.bitwise_and(img, img, mask=mask0)
            # face_extracted1 = cv.bitwise_and(img, img, mask=mask1)

            # background_mask0 = cv.bitwise_not(mask0)
            # background_mask1 = cv.bitwise_not(mask1)
            # background0 = cv.bitwise_and(img, img, mask=background_mask0)
            # background1 = cv.bitwise_and(img, img, mask=background_mask1)

            # result = cv.add(face_extracted0, face_extracted1)


    # cv.imshow("Image 1", img)
    cv.imshow("cropped triangle 1", result)
    # cv.imshow("cropped triangle 2", cropped_triangle2)
    # cv.imshow("Warped triangle", warped_triangle)
    cv.waitKey(1)