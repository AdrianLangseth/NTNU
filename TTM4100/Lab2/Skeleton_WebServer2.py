from socket import *

serverSocket = socket(AF_INET, SOCK_STREAM)
serverPort = 12002
serverSocket.bind(('', serverPort))
serverSocket.listen(1)

while True:
    print("Whattup homeslice?")
    connectionSocket, addr = serverSocket.accept()
    try:
        message = connectionSocket.recv(1024).decode()
        filePath = message.split()[1]
        f = open(filePath[1:])
        outputdata = f.read()
        f.close()
        connectionSocket.send('HTTP/1.1 200 OK\r\n\r\n'.encode())
        response = outputdata + "\r\n"
        connectionSocket.send(response.encode())
        connectionSocket.close()

    except (IOError, IndexError):
        outputdata = '404 Not Found'
        connectionSocket.send(('HTTP/1.1 404 Not Found\r\n\r\n').encode())
        connectionSocket.send("<html><head></head><body><h1>404 Not Found</h1></body></html>\r\n".encode())
        connectionSocket.close()

    serverSocket.close()