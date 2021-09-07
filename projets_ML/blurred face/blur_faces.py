# https://pysource.com/blur-faces-in-real-time-with-opencv-mediapipe-and-python
import cv2
import mediapipe as mp
import numpy as np
from facial_landmarks import FaceLandmarks

# Load face landmarks
fl = FaceLandmarks()

cap = cv2.VideoCapture(0)

while True:
    ret, frame = cap.read()
    frame = cv2.resize(frame, None, fx=0.8, fy=0.8)
    frame_copy = frame.copy()
    height, width, _ = frame.shape
    landmarks=0

    try:
        # 1. Face landmarks detection
        landmarks = fl.get_facial_landmarks(frame)
        convexhull = cv2.convexHull(landmarks)

        # 2. Face blurrying
        mask = np.zeros((height, width), np.uint8)
        # cv2.polylines(mask, [convexhull], True, 255, 3)
        cv2.fillConvexPoly(mask, convexhull, 255)

        # Extract the face
        frame_copy = cv2.blur(frame_copy, (27, 27))
        face_extracted = cv2.bitwise_and(frame_copy, frame_copy, mask=mask)


        # Extract background
        background_mask = cv2.bitwise_not(mask)
        background = cv2.bitwise_and(frame, frame, mask=background_mask)

        # Final result
        result = cv2.add(background, face_extracted)

    except:
        result=frame

    #cv2.imshow("burrred", face_extracted)
    cv2.imshow("Result", result)
    key = cv2.waitKey(30)
    if key == 27:
        break


cap.release()
cv2.destroyAllWindows()