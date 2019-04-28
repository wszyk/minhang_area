//引入js的模块

var app = new Vue({
    el: '#app',
    data: {
        keyword:'',
        pageInfo:[],
        pageNum:1
    },
    //默认获取第一页数据mounted 页面加载完成后立即去先加载
    mounted() {
      this.getUsers();
    },
    methods: {
        pageNumClick(val){
            this.currentPage =val;
            this.getUsers();
        },
	    getUsers(){
	        axios.get("http://localhost:8080/sys/user/searchWithPage",{
	            params:{
	                keyword:this.keyword,
                    pageNum:this.currentPage
                }
            })
                .then(function (response) {
                    app.pageInfo = response.data;
                })
                .catch(function (error) {
                    console.log(error);
                })
        },
        searchClick(){
            console.log('search click');
            this.getUsers();
        },
    
        updateClick(obj){
            sessionStorage["user"]=JSON.stringify(obj);
            location.href="Userupdate.html";

        },
        addClick(){
            location.href="Useradd.html";
        },
        deleteClick(id){
            axios.post('http://localhost:8080/sys/user/delete?id=' + id)
                .then(function (response) {
                    alert("删除成功");
                    location.href="Userlist.html"
                })
                .catch(function (error) {
                    console.log(error);
                })
        },
	}

})
