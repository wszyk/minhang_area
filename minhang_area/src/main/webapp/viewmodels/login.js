var app = new Vue({
    el: '#app',
    data: {
        loginname: '',
        password: ''
    },
    mounted: function () {
    },
    methods:{
        handleLoginClick() {
            console.log('login click');
            this.login();
        },
        login() {
            axios.get('http://localhost:8080/sys/user/login', {
                params: {
                    loginname: this.loginname,
                    password: this.password
                }
            })
                .then(function (response) {
                    console.log(response);
                    location.href = 'Dashboard.html';
                })
                .catch(function (error) {
                    console.log(error.response.data);
                });
        }
    }
})