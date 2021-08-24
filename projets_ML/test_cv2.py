import cv2 as cv
import time

face_cascade = cv.CascadeClassifier('donnees/Detection_de_visages/haarcascade_frontalface_default.xml')

cap = cv.VideoCapture(0)

while True:
    success, img = cap.read()
    gray = cv.cvtColor(img, cv.COLOR_RGB2GRAY)
    faces = face_cascade.detectMultiScale(gray, 1.1, 8)

    try:
        """ for face in faces:
             x, y, w, h = face
             # dessiner le rectangle sur l'image principale
             cv.rectangle(img, (x, y), (x + w, y + h), (0, 255, 0), 2) """
        x1,y1,w1,h1 = faces[0]
        x2,y2,w2,h2 = faces[1]

        face1 = img[y1:y1+h1, x1:x1+w1]
        face2 = img[y2:y2+h2, x2:x2+w2]

        face1 = cv.resize(face1, (w2,h2), interpolation= cv.INTER_LINEAR)
        face2 = cv.resize(face2, (w1,h1), interpolation= cv.INTER_LINEAR)

        img[y1:y1+h1, x1:x1+w1] = face2
        img[y2:y2+h2, x2:x2+w2] = face1
        
    except:
        pass

    cv.imshow("Video",img)

    if cv.waitKey(1) & 0xFF == ord('q'):
        break