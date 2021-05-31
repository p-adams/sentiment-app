<head>
<style>
.container {
    display: flex;
}
.sentiment-container {
    margin-left: 10px;
}
#emoji {
    font-size: 30px;
}

</style>

</head>


<div class="container">
    <textarea id="input"></textarea>
    <div class="sentiment-container">
        <p id="emoji"/>
        <p id="rank"/>
    </div>
   
</div>


<script>
    const $emoji = document.querySelector("#emoji");
    const $rank = document.querySelector("#rank");
    const $input = document.querySelector("#input");

    let timer;
    const pos = ['🙂', '😀', '😃', '😊', '😍'];
    const neg = ['😕', '😟', '😩', '😤', '🤬'];
    $emoji.innerHTML = '😐';
    $rank.innerHTML = 'Rank = neutral: 0';
    $input.focus();
    $input.addEventListener('keyup', e => {
        const text = e.target.value
        if(text) {
            clearTimeout(timer)
            timer = setTimeout(() => {
                sendSentiment(text)
            }, 100)
        }
    })

    async function sendSentiment(text) {
        await fetch("/sentiment", {
            method: 'POST',
            body: text
        })
        
        const { polarity } = await fetch('/sentiment').then((res) => res.json())
        const rank = Math.ceil(Math.floor((polarity * 10) / 2))
        const idx = Math.abs(rank)
        if(polarity === 0) {
            $emoji.innerHTML = '😐'
            $rank.innerHTML = 'Rank = neutral: 0'
        }
        if(polarity > 0) {
            $emoji.innerHTML = pos[idx - 1]
            $rank.innerHTML = `Rank = positive: ${rank}`
        } else if(polarity < 0) {
            $emoji.innerHTML = neg[idx - 1]
            $rank.innerHTML = `Rank = negative: ${rank}`
        }
    }

    sendSentiment()



</script>