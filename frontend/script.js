//alert("This is a webservice.");

// Get references to the button and response area
const button = document.getElementById('fetchButton');
const responseArea = document.getElementById('response');

// Add an event listener to the button
button.addEventListener('click', async () => {
    const url = 'http://localhost:8000/hello';

    responseArea.textContent = 'Test';

    try {
        // Send GET request to the /hello endpoint
        const response = await fetch(url);
        const text = await response.text(); // Expect plain text response

        // Display the response in the <pre> tag
        responseArea.textContent = text;
    } catch (error) {
        // handle errors and display them
        responseArea.textContent = error;
    }

});