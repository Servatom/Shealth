import qrcode
from PIL import Image
import os

def createQR(code, id):
    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_H,
        box_size=10,
        border=4,
    )
    qr.add_data(code)
    qr.make(fit=True)
    img = qr.make_image(fill_color="black", back_color="white").convert('RGB')
    img.save("{}.png".format(id))
    return os.getcwd() + "/{}.png".format(id)