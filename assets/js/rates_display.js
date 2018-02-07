class RatesDisplay {
    constructor(container, socket, channelName) {
        this.container = container;
        this.channelName = channelName;
        this.socket = socket;
        this.initChannel()
    }

    initChannel() {
        this.channel = this.socket.channel('rates:live', {});
        this.channel.join()
            .receive("ok", resp => { this.channel.push("get_rates") })
            .receive("error", resp => { console.log("Unable to join", resp) })

        this.channel.on("update", this.handleUpdate.bind(this))
    }

    handleUpdate(resp) {
        this.drawRates(resp)
    }

    drawRates(rates) {
        this.container.innerHTML = "UPDATING"
        this.container.innerHTML = this.formPaneHtml(rates);
    }

    usdValue(rate) {
        return (1/rate).toFixed(2)
    }

    formPaneHtml(rates) {
        let heading = document.createElement("h3")
        let usdValue = this.usdValue
        let text = ['btc', 'bch', 'eth'].map((k) => {
            return `1 ${k} is ${this.usdValue(rates[k])}$`;
        })
        return `<h3>${text}</h3>`
    }
}

export default RatesDisplay;
