document.addEventListener("DOMContentLoaded", function() {
    const animationBox = document.querySelector('.animation-box');

    animationBox.addEventListener('click', function() {
        let randomColor = getRandomColor();
        this.style.backgroundColor = randomColor;
    });

    function getRandomColor() {
        let letters = '0123456789ABCDEF';
        let color = '#';
        for (let i = 0; i < 6; i++) {
            color += letters[Math.floor(Math.random() * 16)];
        }
        return color;
    }
});
