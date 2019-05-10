<name1>
<div if={!userInfo }>
  <label>userName:</label>
  <input type="text" ref="userName" placeholder="Enter your name"/>
  <button onclick={ userLogin }>Confirm</button>
</div>


<div if={userInfo}>
    <h1>Give {userInfo.userName}. a Pikachu!</h1>
    <button onclick={ userLogout }>Change Name</button>
</div>





<script>
this.userLogin = function(e){
     this.userInfo = {
       userName: this.refs.userName.value,
     }
   }
</script>





</name1>
