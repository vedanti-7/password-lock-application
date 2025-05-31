<html>
<head>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="Home.css">
</head>
<body class="h-screen flex items-center justify-center bg-white dark:bg-gray-900">
    <section class="w-full h-full flex items-center justify-center bg-[url('https://flowbite.s3.amazonaws.com/docs/jumbotron/hero-pattern.svg')] dark:bg-[url('https://flowbite.s3.amazonaws.com/docs/jumbotron/hero-pattern-dark.svg')] bg-cover bg-center">

        <div class="py-6 px-4 text-center max-w-lg">
            <div class="mb-8">
                <h1 class="text-7xl font-bold text-gray-900 dark:text-white leading-tight">
                    <span class="block">Welcome to</span>
                    <span class="inline-flex items-center">
                        Lock
                        <img src="./images/lock-logo2.jpg" alt="Lock Logo" class="w-14 h-14 ml-2">
                    </span>
                </h1>
            </div>
        
            <p class="mb-8 text-2xl text-gray-500 dark:text-gray-300">
                Keep your passwords secretly safe.
            </p>
        
            <form class="w-full mx-auto space-y-4" action="pwdfc" method="POST">
                <input type="hidden" id="id" name="id" value="" />
                <div class="relative">
                    <input type="text" id="name" name= "name" class="block w-full p-3 pl-10 text-base border border-gray-300 rounded-lg bg-white focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-800 dark:border-gray-700 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Enter your name..." required />
                </div>
                <div class="relative">
                    <input type="email" id="email" name="email" class="block w-full p-3 pl-10 text-base border border-gray-300 rounded-lg bg-white focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-800 dark:border-gray-700 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Enter your email..." required />
                </div>
                <div class="relative">
                    <button type="submit" class="w-full text-white bg-blue-700 hover:bg-blue-800 focus:ring-2 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-4 py-2 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">
                        Sign up
                    </button>
                </div>
            </form>

        </div>
    </section>
</body>
</html>