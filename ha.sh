#!/bin/bash

clear

function endscript() {
  exit 1
}

trap endscript 2 15

echo -e "\e[1;37mEnter DNS IPs separated by ' ': \e[0m"
read -a DNS_IPS

echo -e "\e[1;37mEnter Your NameServers separated by ' ': \e[0m"
read -a NAME_SERVERS

LOOP_DELAY=5
echo -e "\e[1;37mCurrent loop delay is \e[1;33m${LOOP_DELAY}\e[1;37m seconds.\e[0m"
echo -e "\e[1;37mWould you like to change the loop delay? \e[1;36m[y/n]:\e[0m "
read -r change_delay

if [[ "$change_delay" == "y" ]]; then
  echo -e "\e[1;37mEnter custom loop delay in seconds \e[1;33m(5-15):\e[0m "
  read -r custom_delay
  if [[ "$custom_delay" =~ ^[5-9]$|^1[0-5]$ ]]; then
    LOOP_DELAY=$custom_delay
  else
    echo -e "\e[1;31mInvalid input. Using default loop delay of ${LOOP_DELAY} seconds.\e[0m"
  fi
fi

DIG_EXEC="DEFAULT"
CUSTOM_DIG=/data/data/com.termux/files/home/go/bin/fastdig
VER=0.3

case "${DIG_EXEC}" in
  DEFAULT|D)
    _DIG="$(command -v dig)"
    ;;
  CUSTOM|C)
    _DIG="${CUSTOM_DIG}"
    ;;
esac

if [ ! $(command -v ${_DIG}) ]; then
  printf "%b" "Dig command failed to run, please install dig(dnsutils) or check the DIG_EXEC & CUSTOM_DIG variable.\n" && exit 1
fi

# Initialize the counter
count=1

check(){
  local border_color="\e[95m"  # Light magenta color
  local success_color="\e[92m"  # Light green color
  local fail_color="\e[91m"    # Light red color
  local header_color="\e[96m"  # Light cyan color
  local reset_color="\e[0m"    # Reset to default terminal color
  local padding="  "            # Padding for aesthetic

  # Header
  echo -e "${border_color}┌────────────────────────────────────────────────┐${reset_color}"
  echo -e "${border_color}│${header_color}${padding}DNS Status Check Results${padding}${reset_color}"
  echo -e "${border_color}├────────────────────────────────────────────────┤${reset_color}"
  
  # Results
  for T in "${DNS_IPS[@]}"; do
    for R in "${NAME_SERVERS[@]}"; do
      result=$(${_DIG} @${T} ${R} +short)
      if [ -z "$result" ]; then
        STATUS="${fail_color}Failed${reset_color}"
      else
        STATUS="${success_color}Success${reset_color}"
      fi
      echo -e "${border_color}│${padding}${reset_color}DNS IP: ${T}${reset_color}"
      echo -e "${border_color}│${padding}NameServer: ${R}${reset_color}"
      echo -e "${border_color}│${padding}Status: ${STATUS}${reset_color}"
    done
  done

  # Check count and Loop Delay
  echo -e "${border_color}├────────────────────────────────────────────────┤${reset_color}"
  echo -e "${border_color}│${padding}${header_color}Check count: ${count}${padding}${reset_color}"
  echo -e "${border_color}│${padding}Loop Delay: ${LOOP_DELAY} seconds${padding}${reset_color}"
  
  # Footer
  echo -e "${border_color}└────────────────────────────────────────────────┘${reset_color}"
}

countdown() {
    for i in 10 9 8 7 6 5 4 3 2 1 0; do
        echo "Checking started in $i seconds..."
        sleep 1
    done
}

echo "[</>] Notes = <h1 style="text-align:center";><big>🐉<font color="#2962ff">I</font><font color="#2979ff">S</font><font color="#448aff">MA</<font color="#82b1ff">EL</font> <font color="#b2ebf2"></font><font color="#80deea">MAD</font><font color="#00acc1">RIGAL</font>🐲</big> <p style="text-align:center;"<br><FONT COLOR="#D6F8FE">██╗░░░██╗██████╗░░██████╗</font><br><font color="#C1EFFC">██║░░░██║██╔══██╗██╔════╝</font><br><font color="#AAEAFC">╚██╗░██╔╝██████╔╝╚█████╗░</font><br><font color="#9ADFF4">░╚████╔╝░██╔═══╝░░╚═══██╗</font><br><font color="#75C2DC">░░╚██╔╝░░██║░░░░░██████╔╝</font><br><font color="#4AA9C8">░░░╚═╝░░░╚═╝░░░░░╚═════╝░<BR></font> <h5 style="text-align:center";><font color="#ffe500">ϲοиєϲταи∂ο...</font> <font color="#ffff00">┣▇▇▇▇═─ 20%</font> <font color="#bfff00">┣▇▇▇▇▇▇▇═─ 40%</font> <font color="#80ff00">┣▇▇▇▇▇▇▇▇▇▇═─ 60%</font> <font color="#00ffbf">┣▇▇▇▇▇▇▇▇▇▇▇▇═─ 80% </font> <font color="#00ffff">┣▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇═─100% </font> <font color="#2962ff">🅒</font><font color="#2979ff">🅞</font><font color="#448aff">🅝</font><font color="#82b1ff">🅔</font><font color="#b2ebf2">🅒</font><font color="#80deea">🅣</font><font color="#00acc1">🅐</font><font color="#00d0ff">🅓</font><font color="#00ffbf">🅞</font><font color="#00ffff"></font></font></h5 style> <h3 style="text-align: center;"><big>📱<span style="color: #2962ff;">ɪ</span><span style="color: #2979ff;">ɴ</span><span style="color: #448aff;">ᴛ</span><span style="color: #82b1ff;">ᴇ</span><span style="color: #90caf9;">ʀ</span><span style="color: #bbdefb;">ɴ</span><span style="color: #e3f2fd;">ᴇ</span><span style="color: #e0f7fa;">ᴛ</span><span style="color: #b2ebf2;"> </span><span style="color: #e0f7fa;">ɪ</span><span style="color: #b2ebf2;">ʟ</span><span style="color: #b2ebf2;">ɪ</span><span style="color: #80deea;">ᴍ</span><span style="color: #00acc1;">ɪ</span><span style="color: #00acc1;">ᴛ</span><span style="color: #0097a7;">ᴀ</span><span style="color: #00838f;">ᴅ</span><span style="color: #006064;">ᴏ</span>🛰</big></h1> <h1 style="text-align:center";>ASTIG<font color="#ff0000">🇵🇭</font><font color="#ffffff"></font><font color="#ff0000"></font><font color="#ffffff"> </font> </font><font color="#ff0000"> </font><font color="#ffffff"></font><font color="#ff0000"></font><font color="#ffffff"></font> </font>PINOY<div> <font color="#ffff00">*╔═══❖•ೋ°</font><font color="#ffff00">°ೋ•❖═══╗*</font> <font color="#78ff00">𝑺𝒐𝒑𝒐𝒓𝒕𝒆 𝒑𝒂𝒓𝒂 𝒕𝒐𝒅𝒐 𝒕𝒊𝒑𝒐 𝒅𝒆 𝒄𝒐𝒏𝒕𝒆𝒏𝒊𝒅𝒐</font><font color="#ffbf00"> *╚═══❖•ೋ° °ೋ•❖═══╝* <div><h6 style="text-align:left";><font color="#ff0000">🔸YouTube</font> <font color="#1b75fc">🔸Facebook: https://m.me/j/Abbwsx98vzHj-mdR/📱</font> 🔸<font color="#8000ff"></font><font color="#8600ff"></font><font color="#8b00ff">T</font><font color="#8f00f6">i</font><font color="#9400ec">k</font><font color="#9800e3"></font><font color="#9c00d9">T</font><font color="#a000d0">o</font><font color="#a500c6">k</font><font color="#a900bd">♪🎊</font> <font color="#fc1b1b">🔸Ɲ</font><font color="#b91d1d">Є</font><font color="#772020">Ƭ</font><font color="#342222">Ƒ</font><font color="#781717">Լ</font><font9 color="#bb0b0b">Ɩ</font><font color="#ff0000">Ҳ</font> <font color="#00ff31">🔸</font><font color="#00ff3b">️</font><font color="#00ff45">M</font><font color="#00ff4e">o</font><font color="#00ff58">v</font><font color="#00ff62">i</font><font color="#00ff6c">s</font><font color="#00ff76">t</font><font color="#00ff80">a</font><font color="#00ff89">r</font><font"
echo""
countdown
  clear

# Main loop
while true; do
  check
  ((count++))  # Increment the counter
  sleep $LOOP_DELAY
done

exit 0
