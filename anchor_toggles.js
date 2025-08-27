// anchor_toggles.js — minimal helper for presence/bts tagging
(async function() {
  try {
    const res = await fetch('anchors_noelictus_book2.json', {cache:'no-store'});
    const data = await res.json();
    const presentIds = new Set((data.characters||[]).filter(c=>c.present).map(c=>c.id));
    const sections = document.querySelectorAll('#anchors-noelictus-book2 article');
    sections.forEach(sec => {
      const id = (sec.id||'').replace('anchor-','');
      const isPresent = presentIds.has(id);
      sec.dataset.present = isPresent ? 'true' : 'false';
      sec.classList.toggle('present--false', !isPresent);
    });
    // Offstage/environment summary
    const hdr = document.createElement('div');
    hdr.className = 'muted';
    hdr.style.marginTop = '0.5rem';
    hdr.textContent = `Arc: ${data.arc} — Phase: ${data.phase} — Veterans present: ${data.veterans_present}`;
    document.querySelector('#anchors-noelictus-book2')?.prepend(hdr);
  } catch (e) {
    console.warn('Anchor toggles failed:', e);
  }
})();