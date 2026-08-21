/*

  Tooplate 2164 Compass
  https://www.tooplate.com/view/2164-compass
  Free HTML CSS Template

*/

/* ================================================
   SCROLL REVEAL — IntersectionObserver
   ================================================ */
const revealElements = document.querySelectorAll('.reveal');
const revealObserver = new IntersectionObserver((entries) => {
    entries.forEach((entry, i) => {
        if (entry.isIntersecting) {
            setTimeout(() => {
                entry.target.classList.add('visible');
            }, i * 80);
            revealObserver.unobserve(entry.target);
        }
    });
}, {
    threshold: 0.15,
    rootMargin: '0px 0px -40px 0px'
});

revealElements.forEach(el => revealObserver.observe(el));

/* setTimeout fallback for iframe preview contexts */
setTimeout(() => {
    revealElements.forEach(el => el.classList.add('visible'));
}, 3000);

/* ================================================
   ROUTE — Crossfade background images per chapter
   ================================================ */
const routeSlides = document.querySelectorAll('.route-bg img');
const chapters = document.querySelectorAll('.chapter[data-chapter]');

const chapterObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            const idx = parseInt(entry.target.dataset.chapter, 10);
            routeSlides.forEach(slide => slide.classList.remove('active'));
            if (routeSlides[idx]) {
                routeSlides[idx].classList.add('active');
            }
        }
    });
}, {
    threshold: 0.4,
    rootMargin: '-10% 0px -10% 0px'
});

chapters.forEach(ch => chapterObserver.observe(ch));

/* ================================================
   MOBILE NAV TOGGLE
   ================================================ */
const toggle = document.querySelector('.nav-toggle');
const mobileNav = document.querySelector('.nav-links--mobile');
const closeBtn = document.querySelector('.nav-close');
const navBar = document.querySelector('.nav-bar');

toggle.addEventListener('click', () => {
    toggle.classList.toggle('active');
    mobileNav.classList.toggle('open');
    document.body.classList.toggle('menu-open');
});

closeBtn.addEventListener('click', () => {
    toggle.classList.remove('active');
    mobileNav.classList.remove('open');
    document.body.classList.remove('menu-open');
});

mobileNav.querySelectorAll('a').forEach(link => {
    link.addEventListener('click', () => {
        toggle.classList.remove('active');
        mobileNav.classList.remove('open');
        document.body.classList.remove('menu-open');
    });
});

/* ================================================
   NAV — Semi-transparent BG on scroll
   ================================================ */
const handleNavScroll = () => {
    if (window.scrollY > 80) {
        navBar.classList.add('scrolled');
    } else {
        navBar.classList.remove('scrolled');
    }
};

window.addEventListener('scroll', handleNavScroll, { passive: true });
handleNavScroll();
