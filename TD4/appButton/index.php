<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <!-- Jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>

<body>
    <button id="btn">
        CLICK ME
    </button>
    <script>
        $(document).ready(function() {
            $("#btn").click(function() {
                $.ajax({
                    url: "increment.php",
                    type: "get",
                    success: function(data) {
                        console.log("success");
                    }
                });
            });
        });
    </script>
</body>

</html>