import cv2
import numpy as np
global colorsH
colorsH=0
def nothing(x):
    pass

cv2.namedWindow("Tracking")
cv2.createTrackbar("LH", "Tracking", 0, 50, nothing)
hsv_colors=0

def mouseHSV(event,x,y,flags,hsv_colors):
    if event == cv2.EVENT_LBUTTONDOWN: #checks mouse left button down condition

        trackbar_value = cv2.getTrackbarPos("LH", "Tracking")
        l_h=frame2[y,x,0]
        l_b = np.array([l_h-trackbar_value, 0, 0])
        u_b = np.array([l_h+trackbar_value, 255, 255])
        mask = cv2.inRange(hsv, l_b, u_b)
        mask3 = np.zeros_like(frame)
        mask3[:, :, 0] = mask
        mask3[:, :, 1] = mask
        mask3[:, :, 2] = mask
        res = cv2.bitwise_and(frame,mask3)
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        gframe = cv2.cvtColor(gray, cv2.COLOR_GRAY2BGR) 
        gray = cv2.bitwise_and(gframe, 255 - mask3)
        out = gray + res
        cv2.imshow('mouseHSV', frame2)
        cv2.imshow("out", out)


# Read an image, a window and bind the function to window
cv2.namedWindow('mouseHSV')
cv2.setMouseCallback('mouseHSV',mouseHSV)


while True:

  frame = cv2.imread('mms.png')
  frame2 = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
  hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)


  key = cv2.waitKey(1)
  if key == 27:
    break


cv2.destroyAllWindows()
