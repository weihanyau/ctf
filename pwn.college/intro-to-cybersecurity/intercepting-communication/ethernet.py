import socket

s = socket.socket(socket.AF_PACKET, socket.SOCK_RAW)
s.bind(("eth0", socket.ETH_P_ALL))
eth_frame = bytearray([
    # Destination Mac
    # NOTE: Broadcast also works
    0x02, 0x2f, 0x79, 0x40, 0x47, 0x30,
    # Source Mac
    0x76, 0xf0, 0xd1, 0xff, 0x36, 0xd6,
    0xFF, 0xFF
])
s.send(eth_frame)