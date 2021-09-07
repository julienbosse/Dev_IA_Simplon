import cv2 as cv
import mediapipe as mp
import time 
import numpy as np

cap = cv.VideoCapture(0)
pTime = 0

mpDraw = mp.solutions.drawing_utils
mpFaceMesh = mp.solutions.face_mesh
mpHands = mp.solutions.hands
faceMesh = mpFaceMesh.FaceMesh(max_num_faces=2)
hands = mpHands.Hands(max_num_hands=4)
drawSpec = mpDraw.DrawingSpec(thickness=1, circle_radius=1)

while True:
    success, img = cap.read()
    imgRGB = cv.cvtColor(img, cv.COLOR_BGR2RGB)
    results = faceMesh.process(imgRGB)
    if results.multi_face_landmarks:
        if len(results.multi_face_landmarks)==1:
            for faceLms in results.multi_face_landmarks:
                mpDraw.draw_landmarks(img, faceLms, mpFaceMesh.FACEMESH_CONTOURS, drawSpec, drawSpec)
        
        elif len(results.multi_face_landmarks)==2:
            height, width, _ = img.shape

            facelandmarks0 = []
            facelandmarks1 = []
            for i in range(0, 468):
                pt0 = results.multi_face_landmarks[0].landmark[i]
                pt1 = results.multi_face_landmarks[1].landmark[i]
                x0 = int(pt0.x * width)
                x1 = int(pt1.x * width)
                y0 = int(pt0.y * height)
                y1 = int(pt1.x * width)
                facelandmarks0.append([x0, y0])
                facelandmarks1.append([x1, y1])

            landmarks0 = np.array(facelandmarks0, np.int32)
            landmarks1 = np.array(facelandmarks1, np.int32)

            convexhull0 = cv.convexHull(landmarks0)
            convexhull1 = cv.convexHull(landmarks1)

            mask = np.zeros((height, width), np.uint8)
            cv.fillConvexPoly(img, convexhull0, 255)
            cv.fillConvexPoly(img, convexhull1, 255)


    resultsHands = hands.process(imgRGB)

    if resultsHands.multi_hand_landmarks:
        for handLms in resultsHands.multi_hand_landmarks:
            mpDraw.draw_landmarks(img,handLms,mpHands.HAND_CONNECTIONS)

    cv.imshow("Image",img)
    cv.waitKey(1)