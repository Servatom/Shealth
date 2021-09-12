import qrcode
from PIL import Image
import os

def createQR(doc_id):
    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_H,
        box_size=10,
        border=4,
    )
    qr.add_data(doc_id)
    qr.make(fit=True)
    img = qr.make_image(fill_color="black", back_color="white").convert('RGB')
    img.save("{}.png".format(doc_id))
    return os.getcwd() + "/{}.png".format(doc_id)