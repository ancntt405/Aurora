document.addEventListener('DOMContentLoaded',()=>{
  // Reveal animations
  document.querySelectorAll('.fade-in').forEach((el,i)=>{
    el.style.animationDelay = (i*60)+'ms';
  });

  // Smooth click ripple for .btn
  document.body.addEventListener('click', (e)=>{
    const btn = e.target.closest('.btn');
    if(!btn) return;
    btn.classList.add('pressed');
    setTimeout(()=>btn.classList.remove('pressed'),140);
  });

  // Confirm deletes with nicer message
  document.querySelectorAll('a[data-confirm],button[data-confirm]').forEach(a=>{
    a.addEventListener('click', (ev)=>{
      const msg = a.getAttribute('data-confirm')||'Bạn có chắc muốn thực hiện thao tác này?';
      if(!confirm(msg)){
        ev.preventDefault();
      }
    });
  });
});
