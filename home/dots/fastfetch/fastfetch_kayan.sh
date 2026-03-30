#!/usr/bin/env zsh

# Check if animation already ran this boot session
EVA_FLAG="/tmp/eva_displayed_$USER"

if [[ -f "$EVA_FLAG" ]]; then
    # Animation already shown this boot, just run fastfetch
    fastfetch
    exit 0
fi

# Create flag file for this boot session
touch "$EVA_FLAG"

# Metinler
JP="エヴァンゲリオン・ユニット02 システム初期化！"
DE="EVANGELION EINHEIT-02 SYSTEM INITIALISIERUNG!"
EN="EVANGELION UNIT-02 SYSTEM INITIALIZED!"

# Renk gradyanı
COLORS=(
    "\033[38;5;196m"
    "\033[38;5;202m"
    "\033[38;5;208m"
    "\033[38;5;214m"
    "\033[38;5;220m"
    "\033[38;5;226m"
)
RESET="\033[0m"

# Terminal boyutları
width=$(tput cols)
height=$(tput lines)
jp_len=${#JP}
de_len=${#DE}
en_len=${#EN}

# Orta nokta
mid_line=1  # Üst satırda göster
center_col=$(( width / 2 ))

# Ekranı temizle ve imleci gizle
clear
tput civis

# Çarpışma animasyonu - soldan JP, sağdan DE
collision_point=$center_col

# Toplam adım sayısını hesapla (2 saniye için daha yavaş)
total_steps=80
sleep_time=0.025  # 2 saniye / 80 adım

for ((i=0; i<=total_steps; i++)); do
    # Sol taraftan Japonca (soldan sağa)
    jp_pos=$(( i * collision_point / total_steps ))
    jp_color_idx=$(( i % ${#COLORS[@]} ))
    jp_color=${COLORS[$((jp_color_idx + 1))]}

    # Sağ taraftan Almanca (sağdan sola)
    de_pos=$(( width - (i * collision_point / total_steps) - de_len ))
    de_color_idx=$(( (total_steps - i) % ${#COLORS[@]} ))
    de_color=${COLORS[$((de_color_idx + 1))]}

    # Ekranı temizle ve metinleri çiz
    printf "\033[${mid_line};1H\033[2K"

    # Japonca metni yaz
    if (( jp_pos >= 0 && jp_pos < width )); then
        printf "\033[${mid_line};${jp_pos}H${jp_color}${JP}${RESET}"
    fi

    # Almanca metni yaz
    if (( de_pos >= 0 && de_pos < width )); then
        printf "\033[${mid_line};${de_pos}H${de_color}${DE}${RESET}"
    fi

    sleep $sleep_time
done

# İç içe geçme animasyonu - metinler birbiri üzerine gelir
for ((i=0; i<=20; i++)); do
    overlap=$(( i * 3 ))

    jp_pos=$(( center_col - jp_len / 2 + overlap ))
    de_pos=$(( center_col - de_len / 2 - overlap ))

    jp_color_idx=$(( i % ${#COLORS[@]} ))
    jp_color=${COLORS[$((jp_color_idx + 1))]}
    de_color=${COLORS[$(( (20 - i) % ${#COLORS[@]} + 1 ))]}

    printf "\033[${mid_line};1H\033[2K"

    # Her iki metni de aynı anda göster/gizle
    if (( de_pos >= 0 )); then
        printf "\033[${mid_line};${de_pos}H${de_color}${DE}${RESET}"
    fi
    if (( jp_pos >= 0 )); then
        printf "\033[${mid_line};${jp_pos}H${jp_color}${JP}${RESET}"
    fi

    sleep 0.03
done

# Metinler tam üst üste gelince İngilizce ortaya çıkar
en_center=$(( (width - en_len) / 2 ))
for ((i=0; i<=10; i++)); do
    alpha=$(( i * 10 ))

    printf "\033[${mid_line};1H\033[2K"

    # JP ve DE aynı anda kaybolur
    if (( i < 8 )); then
        fade_amount=$(( i * 8 ))
        jp_pos=$(( center_col - jp_len / 2 + fade_amount ))
        de_pos=$(( center_col - de_len / 2 - fade_amount ))
        faded_color=${COLORS[6]}

        if (( de_pos >= 0 )); then
            printf "\033[${mid_line};${de_pos}H${faded_color}${DE}${RESET}"
        fi
        if (( jp_pos >= 0 && jp_pos < width )); then
            printf "\033[${mid_line};${jp_pos}H${faded_color}${JP}${RESET}"
        fi
    fi

    # İngilizce giderek belirginleşir
    if (( i > 3 )); then
        printf "\033[${mid_line};${en_center}H${COLORS[1]}${EN}${RESET}"
    fi

    sleep 0.05
done

# Son çarpışma efekti
sleep 0.15

# Ekranı tamamen temizle
clear

# Fastfetch'i arka planda başlat
fastfetch &
FF_PID=$!

# İngilizce yazı için gradient renkler (kırmızı-sarı)
BLINK_COLORS=(
    "\033[38;5;196m"  # Kırmızı
    "\033[38;5;202m"  # Turuncu-kırmızı
    "\033[38;5;208m"  # Turuncu
    "\033[38;5;214m"  # Sarı-turuncu
    "\033[38;5;220m"  # Sarı
    "\033[38;5;226m"  # Parlak sarı
    "\033[38;5;220m"  # Sarı
    "\033[38;5;214m"  # Sarı-turuncu
    "\033[38;5;208m"  # Turuncu
    "\033[38;5;202m"  # Turuncu-kırmızı
)

# İngilizce yazı ile blink efekti (fastfetch ile BERABER)
en_pos=$(( (width - en_len) / 2 ))

for i in {1..10}; do
    color_idx=$(( (i - 1) % ${#BLINK_COLORS[@]} ))
    blink_color=${BLINK_COLORS[$color_idx]}

    # Göster - İngilizce yazı gradient ile
    printf "\033[1;${en_pos}H${blink_color}${EN}${RESET}"
    sleep 0.1

    # Gizle - sadece ilk satırı temizle
    printf "\033[1;1H\033[2K"
    sleep 0.1
done

# Son kez İngilizce yazıyı göster (kırmızı renkte)
printf "\033[1;${en_pos}H${COLORS[1]}${EN}${RESET}\n"

# Fastfetch'in bitmesini bekle
wait $FF_PID

# İmleci göster ve en alta git
tput cnorm
printf "\033[${height};1H"
