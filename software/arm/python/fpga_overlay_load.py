from pynq import Overlay

BIT_PATH = "design_1_wrapper.bit"

def load_overlay():
    ol = Overlay(BIT_PATH, download=True)
    cnn = ol.cnn_axi_ip1_0
    return cnn
