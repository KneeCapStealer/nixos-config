{ pkgs, ... }:

{
  imports = [
    ./web.nix
  ];


  environment.systemPackages = with pkgs; [
    llvmPackages_latest.lld
    llvmPackages_latest.lldb
    llvmPackages_latest.clangUseLLVM
    llvmPackages_latest.stdenv
    llvmPackages_latest.libcxx
    llvmPackages_latest.libunwind
    llvmPackages_latest.compiler-rt-libc
    llvmPackages_latest.bintools
    llvmPackages_latest.clang-tools
  ];
}
