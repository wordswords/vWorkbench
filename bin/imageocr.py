import pytesseract
import sys
from PIL import Image

def ocr_text(image_path):
    try:
        img = Image.open(image_path)
        text = pytesseract.image_to_string(img)
        print("Extracted Text:\n", text)
    except Exception as e:
        print(f"Error: {e}")

if len(sys.argv) < 2:
    print("Usage: " + sys.argv[0] + " <image to extract>")
    exit(1)

ocr_text(sys.argv[1])


