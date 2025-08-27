(async function(){
 const res=await fetch('../assets/json/audiobooks.json'); const data=await res.json();
 const q=document.getElementById('q'); const list=document.getElementById('list');
 function ok(v){return (v||'').toLowerCase();}
 function draw(){ list.innerHTML=''; const s=ok(q.value);
  data.forEach(d=>{ if(s && !(ok(d.title).includes(s)||ok(d.author).includes(s))) return;
   const el=document.createElement('article'); el.className='card';
   el.innerHTML=`<h3>${d.title}</h3><div>${d.author}</div><div class="small">ASIN: ${d.asin||'—'} · ${d.status}</div>
   <a href="${d.link}" target="_blank" rel="noopener">Open</a>`; list.appendChild(el);
  });
 } q.addEventListener('input',draw); draw();
})();
