#ifndef UNICODE
#define UNICODE
#endif

#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif

#include <winsock2.h>
#include <Ws2tcpip.h>
#include <stdio.h>
#include <iostream>

// Link with ws2_32.lib
#pragma comment(lib, "Ws2_32.lib")

int main()
{
    std::cout << "SOCK_DGRAM : " << SOCK_DGRAM << "\n";
    std::cout << "SOCK_RAW : " << SOCK_RAW << "\n";
    std::cout << "SOCK_SEQPACKET : " << SOCK_SEQPACKET << "\n";
    std::cout << "SOCK_STREAM : " << SOCK_STREAM << "\n";
    std::cout << "SOL_SOCKET : " << SOL_SOCKET << "\n";
    std::cout << "SO_BROADCAST : " << SO_BROADCAST << "\n";
    std::cout << "SO_KEEPALIVE : " << SO_KEEPALIVE << "\n";
    std::cout << "SO_LINGER : " << SO_LINGER << "\n";
    std::cout << "SO_RCVBUF : " << SO_RCVBUF << "\n";
    std::cout << "SO_REUSEADDR : " << SO_REUSEADDR << "\n";
    std::cout << "SO_SNDBUF : " << SO_SNDBUF << "\n";
    std::cout << "PF_INET : " << PF_INET << "\n";
    std::cout << "PF_INET6 : " << PF_INET6 << "\n";
    std::cout << "PF_UNIX : " << PF_UNIX << "\n";
    std::cout << "PF_UNSPEC : " << PF_UNSPEC << "\n";
    std::cout << "AF_INET : " << AF_INET << "\n";
    std::cout << "AF_INET6 : " << AF_INET6 << "\n";
    std::cout << "AF_UNIX : " << AF_UNIX << "\n";
    std::cout << "AF_UNSPEC : " << AF_UNSPEC << "\n";
    return 0;
}