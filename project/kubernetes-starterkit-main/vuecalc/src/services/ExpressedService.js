import axios from 'axios'

require('dotenv').config();

const url = process.env.VUE_APP_EXPRESSED;

export default {
    getAdditionResult (num1, num2) {
        return axios.get(url + '/add?num1=' + num1 + '&num2=' + num2);
    },
    getSubtractionResult (num1, num2) {
        return axios.get(url + '/subtract?num1=' + num1 + '&num2=' + num2);
    }
}