{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
  ];
  powerManagement.cpuFreqGovernor = "performance";

  # Desktop-only: AzureWave RTL8821CE (rtw88) — auth/association timeouts.
  # Out-of-tree rtl8821ce does not build on kernel 7.1.x, so tune rtw88 instead.
  boot.extraModprobeConfig = ''
    options cfg80211 ieee80211_regdom="AU"
    options rtw88_pci disable_aspm=y disable_msi=y
    options rtw88_core disable_lps_deep=y
  '';

  # Keep the Wi‑Fi NIC awake (runtime PM causes drops on this chip)
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10ec", ATTR{device}=="0xc821", TEST=="power/control", ATTR{power/control}="on"
    ACTION=="add", SUBSYSTEM=="net", KERNEL=="wlp*", TEST=="power/control", ATTR{power/control}="on"
  '';
}
