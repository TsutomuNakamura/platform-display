#!/usr/bin/env bash

main () {
    local word="$1"
    local width="$(tput cols)"

    local len_of_word=${#word}
    local position=$width

    local pad_head=$(( $width - $position ))

    local count
    local word_start
    local word_end
    for count in $( seq 1 $((width + $len_of_word + 1)) ); do
        if [[ $position -le 0 ]]; then
            word_start=$(( len_of_word - $((len_of_word + position)) ))
            word_end=$((len_of_word - word_start))
            echo -n ${word:${word_start}:${word_end}}
            printf ' %.0s' $( seq 1 $((count - len_of_word - 1 )) )
            [[ $position -eq 0 ]] && sleep 2
        elif [[ $position -ge $(( width - len_of_word ))  ]]; then
            word_start=0
            word_end=$((width - position))
            printf ' %.0s' $( seq 1 $(( width - count + 1 )) )
            echo -n ${word:${word_start}:$word_end}
        else
            printf ' %.0s' $( seq 1 $(( width - count + 1 )) )
            echo -n ${word}
            printf ' %.0s' $( seq 1 $((count - len_of_word - 1 )) )
        fi

        (( --position ))
        echo -en '\r'
        sleep .03
    done
    sleep .5
    echo
}

main "$@"

