<?php
  if(
    empty($_POST["username"]) ||
    empty($_POST["password"])
  ) {
?>
<html>
  <head>
    <title>Form authentication</title>
  </head>
  <body>
    <table>
     <form method="post">
      <tr>
       <td>Username</td>
       <td><input type="text" name="username"></td>
     </tr>
     <tr>
       <td>Password</td>
       <td><input type="password" name="password"></td>
     </tr>
     <tr>
       <td><input type="submit" name="submit" value="Login"></td>
     </tr>
   </form>
 </table>
</body>
</html>
<?php
  } else {
    $hash = '$2y$10$mBErSF12wVGjPi5qHFXQH..DcY.6wnqlN8t8A6cSOYRKfMNBXDTfK';

    if(
      $_POST["username"] == "admin" &&
      password_verify($_POST["password"], $hash)
    ) {
      echo "Login successful!\n";
    } else {
      echo "Login failed :(\n";
    }
  }
?>
