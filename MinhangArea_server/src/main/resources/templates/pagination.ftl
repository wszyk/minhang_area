<div id="pagination" > 			  			  
	<div> 
    	<div class="page"  v-show="show"> 
           	<div class="pagelist"> 
       			<span class="jump"v-show="pageNum>1" @click="prePage()">上一页</span> 
        		<span v-show="pageNum>5" class="jump" @click="jumpPage(1)">1</span> 
        		<span class="ellipsis"  v-show="efont">...</span> 
         		<span class="jump" v-for="num in indexs" :class="{bgprimary:pageNum==num}" @click="jumpPage(num)">{{num}}</span> 
         		<span class="ellipsis"  v-show="efont&&pageNum<pages-4">...</span> 
         		<span class="jump" @click="nextPage()">下一页</span> 
         		<span v-show="pageNum<pages-1" class="jump" class="jump" @click="jumpPage(pages)">{{pages}}</span> 
         		<span class="jumppoint">跳转到：</span> 
         		<span class="jumpinp"><input type="text" v-model="changePage"></span> 
        		<span class="jump gobtn" @click="jumpPage(changePage)">GO</span> 
       		</div> 
     	</div> 
   	</div> 
 </div>