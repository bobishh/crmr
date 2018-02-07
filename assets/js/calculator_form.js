import $ from 'jquery'

class CalculatorForm {
    constructor(container) {
        this.container = container
        this.initForm()
        this.initListeners()
    }

    initListeners() {
        this.container.querySelector('form').addEventListener('submit', this.handleSubmit.bind(this));
    }

    handleSubmit(e) {
        e.preventDefault();
        $.ajax({method: "GET",
                url: this.formQueryString(),
                success: ((data) => {
                    this.renderResult(data.result);
                }).bind(this)});
    }

    renderResult(value) {
        this.container.querySelector('#result').innerHTML = this.resultString(value)
    }

    resultString(value) {
        return `${this.getSum()} ${this.getCurrency()} is ${value}$`
    }

    formQueryString() {
        return `/api/calc?currency=${this.getCurrency()}&sum=${this.getSum()}&timestamp=${this.getTimestamp()}`
    }

    getCurrency() {
        return this.container.querySelector("select[name='currency']").value
    }

    getSum() {
        return this.container.querySelector("input[name='sum']").value
    }

    getTimestamp() {
        return this.container.querySelector("input[name='timestamp']").value
    }

    initForm() {
        this.container.innerHTML = this.formTemplate()
    }

    formTemplate() {
       return `
<div class="form__container">
    <form action="/api/calc" name='calculator_form' method="GET">
        <select name="currency">
            <option value="btc">BTC</option>
            <option value="bch">BCH</option>
            <option value="eth">ETH</option>
        </select>
        <input type="text" name="sum">
        </input>
        <input name="timestamp" type="datetime">
        </input>
        <input type="submit" value="calculate!"></input>
        <h3 id='result'></h3>
    </form>
</div>
`
    }
}

export default CalculatorForm;
