
<div id="data"/>


<textarea id="input"></textarea>

<script>
    const $data = document.querySelector("#data");
    const $input = document.querySelector("#input")
    let timer
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

        console.log(polarity)
        

    }

    sendSentiment()



</script>