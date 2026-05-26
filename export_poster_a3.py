from pathlib import Path

from PIL import Image
from reportlab.lib.pagesizes import A3
from reportlab.pdfgen import canvas


SOURCE = Path(r"C:\Users\dev03\Downloads\Poster.jpg")
OUTPUT = Path(r"D:\dscity-mobile-app-dev\Poster-A3.pdf")


def main() -> None:
    page_width, page_height = A3

    with Image.open(SOURCE) as image:
        image_width, image_height = image.size

    scale = min(page_width / image_width, page_height / image_height)
    draw_width = image_width * scale
    draw_height = image_height * scale
    x = (page_width - draw_width) / 2
    y = (page_height - draw_height) / 2

    pdf = canvas.Canvas(str(OUTPUT), pagesize=A3)
    pdf.drawImage(str(SOURCE), x, y, width=draw_width, height=draw_height, preserveAspectRatio=True)
    pdf.showPage()
    pdf.save()


if __name__ == "__main__":
    main()
