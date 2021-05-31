
<div>
    <textarea id="input"></textarea>
    <canvas id="canvas" height="200" width="300"></canvas>
</div>

<style>
div {
    display: flex;
}
canvas {
    border: 1px solid grey;
}

</style>


<script>
    const $data = document.querySelector("#data");
    const $input = document.querySelector("#input")
    const ctx = document.querySelector("#canvas").getContext("2d")
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
        ctx.beginPath()
        ctx.arc(40, 40, 10, 0, Math.PI * 2)
        ctx.stroke()
        ctx.closePath()

        if(polarity === 0) {
            return;
        }
        if(polarity > 0) {
            // draw positive
            return
        }

        console.log(polarity)
        

    }

    sendSentiment()



</script>