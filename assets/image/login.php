<?php  
if(isset(["submit"])){
    $username=['username'];
    $password=['password'];
    $email=['email'];

}
<!there is a need to clean up the password and username to avoid hackers --->
$username=mysqli_real_escape_string('username');
$password=mysqli_real_escape_string('password');

if($username < 5 && $password< 7){
    echo "your password has to be longer than 7 characrters, <a href='#'>suggest a password? </a>"

}
else{
    header("Location:mainpage.php");
}



?>

<div claas="container">
    <div class="row">
        <div class"col-sm-6">
            <P>Hello,you have to register your details before you can acess our website</p>
            <P>enter your details below to recieve a notification from us via your email</p>


<div class="card">
    <div class="card-body card-danger">

<form  action ="#" method="post" >
    <div  class="form-group">
        <label for="username">username</label>
        <form type="text" class="form-control" name="username" value="username">
</div>
<div class="form-group">
    <label for="password">password</label>
    <form type="text" class="form-group" name="password" value="password">
</div>
<div class="form-group">
    <form type="email" class="form-control" name="email" value="email">
<div class="form-group">
    <form type="submit" name="submit" value="submit" lass="btn btn-rounded">
</div>
</div>
</div>
<hr>


    