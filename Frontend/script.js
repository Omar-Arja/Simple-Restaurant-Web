// Login Functionality
document.getElementById('login-btn').addEventListener('click', async () => {
    const email = document.getElementById('login-email').value.trim();
    const password = document.getElementById('login-password').value.trim();

    console.log({ email, password }); // Debugging step

    if (!email || !password) {
        alert('Please fill in all fields.');
        return;
    }

    try {
        // Create FormData
        const formData = new FormData();
        formData.append('email', email);
        formData.append('password', password);

        const response = await fetch('http://localhost:8000/api/login.php', {
            method: 'POST',
            body: formData, // Send FormData
        });

        const data = await response.json();

        if (data.success) {
            alert('Login successful!');
            localStorage.setItem('user', JSON.stringify(data.user));
            window.location.href = 'index.html';
        } else {
            alert(data.message || 'Login failed.');
        }
    } catch (error) {
        console.error(error);
        alert('An error occurred. Please try again.');
    }
});

// Register Functionality
document.getElementById('register-btn').addEventListener('click', async () => {
    const name = document.getElementById('register-name').value.trim();
    const email = document.getElementById('register-email').value.trim();
    const phone = document.getElementById('register-phone').value.trim();
    const password = document.getElementById('register-password').value.trim();

    console.log({ name, email, phone, password }); // Debugging step

    if (!name || !email || !phone || !password) {
        alert('Please fill in all fields.');
        return;
    }

    try {
        // Create FormData
        const formData = new FormData();
        formData.append('name', name);
        formData.append('email', email);
        formData.append('phone', phone);
        formData.append('password', password);

        const response = await fetch('http://localhost:8000/api/register.php', {
            method: 'POST',
            body: formData, // Send FormData
        });

        const data = await response.json();

        if (data.success) {
            alert('Registration successful!');
            localStorage.setItem('user', JSON.stringify(data.user));
            window.location.href = 'index.html';
        } else {
            alert(data.message || 'Registration failed.');
        }
    } catch (error) {
        console.error(error);
        alert('An error occurred. Please try again.');
    }
});