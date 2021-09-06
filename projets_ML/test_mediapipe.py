import cv2 as cv
import mediapipe as mp
import time 

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
        for faceLms in results.multi_face_landmarks:
            mpDraw.draw_landmarks(img, faceLms, mpFaceMesh.FACEMESH_CONTOURS, drawSpec, drawSpec)

    resultsHands = hands.process(imgRGB)

    if resultsHands.multi_hand_landmarks:
        for handLms in resultsHands.multi_hand_landmarks:
            mpDraw.draw_landmarks(img,handLms,mpHands.HAND_CONNECTIONS)

    cv.imshow("Image",img)
    cv.waitKey(1)