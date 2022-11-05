import axios from 'axios'

require('dotenv').config();

const url = process.env.VUE_APP_HAPPY;

export default {
    getMultiplicationResult (num1, num2) {
        return axios.get(url + '/multiply?num1=' + num1 + '&num2=' + num2);
    },
    getDivisionResult (num1, num2) {
        return axios.get(url + '/divide?num1=' + num1 + '&num2=' + num2);
    }
}
