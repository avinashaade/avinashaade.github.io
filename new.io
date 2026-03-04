import { useState, useEffect, useRef } from "react";

// ── DATA ──────────────────────────────────────────────────────────────────────

const NAV_LINKS = ["About","Skills","Experience","Projects","Teaching","Blog","Notes","Contact"];

const SKILLS = [
  { label: "Programming", color: "#00D4FF", items: ["Java","Python","SQL","OOP"] },
  { label: "Testing",     color: "#00FF88", items: ["Selenium WebDriver","RestAssured","TestNG","Cucumber (BDD)","PyTest","Playwright (POC)","Postman","Page Object Model"] },
  { label: "Tools & DevOps", color: "#FF6B35", items: ["Git","GitHub Actions","Jenkins","JIRA","Confluence","VS Code","Chrome DevTools","Maven"] },
  { label: "Expertise",   color: "#FFD60A", items: ["Functional Testing","Regression Testing","API Testing","Mobile Testing","Cross-browser Testing","Agile / Scrum","MongoDB","Allure Reports"] },
];

const EXPERIENCE = [
  {
    role: "QA Automation Engineer",
    company: "CCtech",
    period: "Dec 2025 – Present",
    color: "#00D4FF",
    bullets: [
      "Designed detailed manual test cases for Recap and InfraWorks workflows",
      "Performed functional validation aligned with business requirements",
      "Developed foundational automation scripts using Python and PyTest",
      "Participated in knowledge transfer sessions and supported Agile QA activities",
    ],
    awards: [],
  },
  {
    role: "Software Engineer — QA",
    company: "Mphasis Limited",
    period: "Dec 2021 – Aug 2025",
    color: "#00FF88",
    bullets: [
      "Designed and maintained hybrid automation frameworks using Selenium and RestAssured",
      "Increased automation coverage by 80% using TestNG and Cucumber",
      "Implemented Page Object Model (POM) for reusable test components",
      "Automated API testing for multiple HTTP methods with payload validation",
      "Integrated automation with Jenkins · generated Extent & Allure reports",
      "Mentored junior QA engineers on automation best practices",
    ],
    awards: ["🏆 Employee of the Month", "🏆 Laurel Award — Best Performer"],
  },
];

const PROJECTS = [
  { num:"001", client:"Charles Schwab", title:"Financial Brokerage Platform", tech:"Selenium · RestAssured · Jenkins · Allure · SQL · MongoDB", color:"#00D4FF", desc:"End-to-end QA automation for a large-scale financial brokerage platform at Mphasis.", features:["Functional, regression & API testing","Playwright POC for execution speed improvements","BDD scenarios with Cucumber + Jenkins + Allure","Data integrity validation via SQL & MongoDB"] },
  { num:"002", client:"Trexo.Money",    title:"Digital Banking Platform",      tech:"Selenium · TestNG · Postman · Jenkins · Maven",             color:"#00FF88", desc:"Mobile and web test automation for a digital banking application on Android and iOS.", features:["Manual testing for Android & iOS apps","Web automation with Selenium + TestNG","Backend API validation with Postman","Nightly runs via Maven + Jenkins"] },
  { num:"003", client:"CCtech",         title:"Recap & InfraWorks QA",         tech:"Python · PyTest · Manual Testing",                         color:"#FF6B35", desc:"Test case design and automation scripting for Recap and InfraWorks engineering workflows.", features:["Detailed manual test case design","Functional validation vs business requirements","Foundational Python + PyTest automation scripts","Cross-functional Agile QA collaboration"] },
  { num:"004", client:"Personal",       title:"Hybrid Automation Framework",   tech:"Java · Selenium · TestNG · Cucumber · Jenkins",            color:"#FFD60A", desc:"Built and maintained a hybrid framework at Mphasis that boosted coverage by 80%.", features:["Page Object Model architecture","80% increase in automation coverage","Extent & Allure report integration","Mentored junior QA engineers on the framework"] },
  { num:"005", client:"UPCOMING",       title:"AI Testing Assistant",          tech:"Python + AI/LLM APIs",                                     color:"#00D4FF", desc:"An AI-powered tool that auto-generates test artifacts — currently in ideation phase.", features:["Generate Selenium test cases from specs","Auto-create bug reports","Natural language to test code","Inspired by Playwright & BDD experience"], future: true },
];

const BLOG_POSTS = [
  { tag:"Python",   color:"#00D4FF", title:"Python for Beginners: From Zero to Automation",    excerpt:"Start your Python journey with practical examples that lead directly into test automation workflows." },
  { tag:"Selenium", color:"#00FF88", title:"Selenium Automation: A Practical Tutorial",         excerpt:"Step-by-step guide to writing your first Selenium test in Python — from setup to running your first script." },
  { tag:"SQL",      color:"#FF6B35", title:"SQL Basics Every QA Engineer Must Know",            excerpt:"Database queries that every tester needs — SELECT, JOIN, WHERE, and writing test data validation queries." },
  { tag:"Roadmap",  color:"#FFD60A", title:"Automation Testing Roadmap for 2025",              excerpt:"A clear learning path from manual testing to building full automation frameworks — skills, tools, and order." },
];

const NOTES = [
  { title:"Selenium — Common Commands",  items:[["driver.get(url)","Open a URL"],["find_element('id', val)","Locate by ID"],[".send_keys('text')","Type into input"],[".click()","Click element"],["driver.quit()","Close browser"],["WebDriverWait()","Explicit wait"]] },
  { title:"PyTest — Key Features",       items:[["@pytest.fixture","Setup/teardown"],["@pytest.mark.parametrize","Data-driven tests"],["assert x == y","Assertion"],["conftest.py","Shared fixtures"],["pytest -v","Verbose output"],["pytest --html=report","HTML report"]] },
  { title:"Interview Questions",         items:[["What is POM?","Page Object Model pattern"],["Implicit vs Explicit Wait","Timing strategies"],["What is a fixture?","Test setup/teardown"],["Selenium Grid?","Parallel execution"],["Headless testing?","No UI browser run"],["CI/CD for QA?","Jenkins pipeline"]] },
  { title:"Automation Frameworks",       items:[["Data-Driven","Tests from external data"],["Keyword-Driven","Action keyword tables"],["Hybrid","Mix of both"],["BDD (Behave)","Gherkin syntax"],["POM","Page Object Model"],["Modular","Reusable components"]] },
];

const CONTACT_LINKS = [
  { icon:"✉",  label:"Email",    value:"avinash.aade.14@gmail.com", href:"mailto:avinash.aade.14@gmail.com" },
  { icon:"🐙", label:"GitHub",   value:"github.com/avinashaade",    href:"https://github.com/avinashaade" },
  { icon:"💼", label:"LinkedIn", value:"linkedin.com/in/avinashaade",href:"https://linkedin.com/in/avinashaade" },
  { icon:"📱", label:"Phone",    value:"+91 73506 71938",            href:"tel:+917350671938" },
];

// ── STYLES ────────────────────────────────────────────────────────────────────

const G = `
  @import url('https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@300;400;600;700&family=Outfit:wght@300;400;600;700;800&display=swap');
  *,*::before,*::after{margin:0;padding:0;box-sizing:border-box;}
  :root{
    --bg:#0A0F1E;--bg2:#0D1528;--bg3:#111D35;
    --accent:#00D4FF;--accent2:#FF6B35;--green:#00FF88;--yellow:#FFD60A;
    --text:#E8EDF5;--muted:#6B7A99;--border:rgba(0,212,255,0.12);
  }
  html{scroll-behavior:smooth;}
  body{background:var(--bg);color:var(--text);font-family:'Outfit',sans-serif;font-weight:300;overflow-x:hidden;line-height:1.6;}
  ::-webkit-scrollbar{width:4px;}
  ::-webkit-scrollbar-track{background:var(--bg);}
  ::-webkit-scrollbar-thumb{background:var(--accent);border-radius:2px;}
  @keyframes fadeUp{from{opacity:0;transform:translateY(30px);}to{opacity:1;transform:translateY(0);}}
  @keyframes pulse{0%,100%{opacity:1;}50%{opacity:0.3;}}
  @keyframes blink{0%,49%{opacity:1;}50%,100%{opacity:0;}}
  @keyframes reveal{to{opacity:1;transform:none;}}
  .reveal{opacity:0;transform:translateY(28px);transition:opacity 0.7s ease,transform 0.7s cubic-bezier(0.16,1,0.3,1);}
  .reveal.visible{opacity:1;transform:none;}
`;

const s = {
  // nav
  nav: { position:"fixed",top:0,left:0,right:0,zIndex:200,display:"flex",justifyContent:"space-between",alignItems:"center",padding:"18px 60px",background:"rgba(10,15,30,0.95)",backdropFilter:"blur(20px)",borderBottom:"1px solid rgba(0,212,255,0.12)" },
  navLogo: { fontFamily:"'JetBrains Mono',monospace",fontWeight:700,fontSize:"1rem",color:"#00D4FF",textDecoration:"none",letterSpacing:"0.05em" },
  navLinks: { display:"flex",gap:28,alignItems:"center" },
  navLink: { color:"#6B7A99",textDecoration:"none",fontSize:"0.82rem",letterSpacing:"0.08em",textTransform:"uppercase",padding:"6px 0",transition:"color 0.2s" },
  hamburger: { display:"none",flexDirection:"column",gap:5,background:"none",border:"none",cursor:"pointer",padding:4 },
  hamburgerBar: { display:"block",width:24,height:2,background:"#00D4FF",borderRadius:2,transition:"transform 0.3s, opacity 0.3s" },
  dropdown: { position:"fixed",top:61,left:0,right:0,background:"rgba(10,15,30,0.98)",borderBottom:"1px solid rgba(0,212,255,0.12)",flexDirection:"column",padding:"16px 24px 24px",gap:4,zIndex:199 },
  dropLink: { color:"#E8EDF5",textDecoration:"none",fontSize:"1rem",padding:"12px 0",borderBottom:"1px solid rgba(0,212,255,0.12)",letterSpacing:"0.06em",textTransform:"uppercase" },
  // hero
  hero: { minHeight:"100vh",display:"flex",alignItems:"center",padding:"100px 60px 60px",position:"relative",overflow:"hidden" },
  heroBg: { position:"absolute",inset:0,background:"radial-gradient(ellipse 60% 50% at 70% 50%, rgba(0,212,255,0.07) 0%, transparent 70%), radial-gradient(ellipse 40% 40% at 20% 80%, rgba(255,107,53,0.06) 0%, transparent 60%)" },
  heroGrid: { position:"absolute",inset:0,backgroundImage:"linear-gradient(rgba(0,212,255,0.04) 1px, transparent 1px), linear-gradient(90deg, rgba(0,212,255,0.04) 1px, transparent 1px)",backgroundSize:"60px 60px" },
  heroContent: { position:"relative",zIndex:2,maxWidth:780 },
  badge: { display:"inline-flex",alignItems:"center",gap:8,background:"rgba(0,212,255,0.08)",border:"1px solid rgba(0,212,255,0.25)",padding:"7px 16px",borderRadius:100,marginBottom:28,fontFamily:"'JetBrains Mono',monospace",fontSize:"0.72rem",color:"#00D4FF",letterSpacing:"0.1em",animation:"fadeUp 0.7s ease both" },
  badgeDot: { width:6,height:6,background:"#00FF88",borderRadius:"50%",animation:"pulse 2s infinite" },
  heroName: { fontFamily:"'Outfit',sans-serif",fontWeight:800,fontSize:"clamp(3.2rem, 7vw, 6.5rem)",lineHeight:1,color:"#E8EDF5",marginBottom:12,animation:"fadeUp 0.8s ease both",animationDelay:"0.1s" },
  heroTitle: { fontFamily:"'JetBrains Mono',monospace",fontWeight:400,fontSize:"clamp(0.9rem, 2vw, 1.2rem)",color:"#6B7A99",marginBottom:24,animation:"fadeUp 0.8s ease both",animationDelay:"0.2s" },
  heroIntro: { fontSize:"1.05rem",lineHeight:1.8,color:"#E8EDF5",opacity:0.75,maxWidth:580,marginBottom:44,animation:"fadeUp 0.8s ease both",animationDelay:"0.3s" },
  heroBtns: { display:"flex",gap:16,flexWrap:"wrap",animation:"fadeUp 0.8s ease both",animationDelay:"0.4s" },
  btnPrimary: { background:"#00D4FF",color:"#0A0F1E",padding:"13px 28px",fontWeight:700,fontSize:"0.85rem",letterSpacing:"0.06em",textTransform:"uppercase",textDecoration:"none",border:"none",display:"inline-flex",alignItems:"center",gap:8,cursor:"pointer",transition:"transform 0.2s, box-shadow 0.2s" },
  btnOutline: { border:"1px solid rgba(0,212,255,0.12)",color:"#E8EDF5",padding:"13px 28px",fontSize:"0.85rem",letterSpacing:"0.06em",textTransform:"uppercase",textDecoration:"none",display:"inline-flex",alignItems:"center",gap:8,transition:"border-color 0.2s, color 0.2s" },
  terminal: { position:"absolute",right:60,top:"50%",transform:"translateY(-50%)",width:380,background:"#111D35",border:"1px solid rgba(0,212,255,0.12)",borderRadius:8,overflow:"hidden",zIndex:2,animation:"fadeUp 1s ease both",animationDelay:"0.5s" },
  termBar: { background:"#0D1528",padding:"10px 16px",display:"flex",alignItems:"center",gap:8 },
  termBody: { padding:20,fontFamily:"'JetBrains Mono',monospace",fontSize:"0.78rem",lineHeight:2 },
  // section
  section: { padding:"100px 60px" },
  secLabel: { fontFamily:"'JetBrains Mono',monospace",fontSize:"0.7rem",letterSpacing:"0.25em",textTransform:"uppercase",color:"#00D4FF",marginBottom:12 },
  secTitle: { fontFamily:"'Outfit',sans-serif",fontWeight:800,fontSize:"clamp(2rem,4vw,3rem)",color:"#E8EDF5",marginBottom:16,lineHeight:1.1 },
  secSub: { color:"#6B7A99",fontSize:"1rem",maxWidth:540,lineHeight:1.7 },
};

// ── HOOKS ─────────────────────────────────────────────────────────────────────

function useReveal() {
  useEffect(() => {
    const els = document.querySelectorAll(".reveal");
    const obs = new IntersectionObserver(entries => {
      entries.forEach(e => { if (e.isIntersecting) e.target.classList.add("visible"); });
    }, { threshold: 0.08 });
    els.forEach(r => obs.observe(r));
    return () => obs.disconnect();
  }, []);
}

function scrollTo(id) {
  const el = document.getElementById(id);
  if (el) { const top = el.getBoundingClientRect().top + window.scrollY - 70; window.scrollTo({ top, behavior:"smooth" }); }
}

// ── COMPONENTS ────────────────────────────────────────────────────────────────

function Nav() {
  const [open, setOpen] = useState(false);
  return (
    <>
      <style>{`
        @media(max-width:768px){
          .desktop-nav{display:none!important;}
          .hamburger-btn{display:flex!important;}
        }
      `}</style>
      <nav style={s.nav}>
        <a href="#home" style={s.navLogo} onClick={e=>{e.preventDefault();scrollTo("home")}}>AA<span style={{color:"#FF6B35"}}>/</span>dev</a>
        <div className="desktop-nav" style={s.navLinks}>
          {NAV_LINKS.map(l => <a key={l} href={`#${l.toLowerCase()}`} style={s.navLink} onClick={e=>{e.preventDefault();scrollTo(l.toLowerCase())}}
            onMouseEnter={e=>e.target.style.color="#00D4FF"} onMouseLeave={e=>e.target.style.color="#6B7A99"}>{l}</a>)}
        </div>
        <button className="hamburger-btn" onClick={() => setOpen(o => !o)}
          style={{display:"none",flexDirection:"column",gap:5,background:"none",border:"none",cursor:"pointer",padding:4}}>
          {[0,1,2].map(i => <span key={i} style={{...s.hamburgerBar,
            transform: open ? (i===0?"translateY(7px) rotate(45deg)":i===2?"translateY(-7px) rotate(-45deg)":"none") : "none",
            opacity: open && i===1 ? 0 : 1
          }}/>)}
        </button>
      </nav>
      {open && (
        <div style={{...s.dropdown, display:"flex"}}>
          {NAV_LINKS.map(l => <a key={l} href={`#${l.toLowerCase()}`} style={s.dropLink}
            onClick={e=>{e.preventDefault();scrollTo(l.toLowerCase());setOpen(false)}}>{l}</a>)}
        </div>
      )}
    </>
  );
}

function Hero() {
  return (
    <section style={s.hero} id="home">
      <div style={s.heroBg}/>
      <div style={s.heroGrid}/>
      <div style={s.heroContent}>
        <div style={s.badge}><span style={s.badgeDot}/> 4+ Years Experience · Open to Opportunities</div>
        <h1 style={s.heroName}>Avinash <span style={{color:"#00D4FF"}}>Aade</span></h1>
        <p style={s.heroTitle}>QA Automation Engineer &nbsp;|&nbsp; <span style={{color:"#FF6B35"}}>Selenium · Java · Python</span> &nbsp;|&nbsp; API & Mobile Testing</p>
        <p style={s.heroIntro}>QA Automation Engineer with 4+ years of experience in web, API, and mobile testing. Specializing in Selenium (Java) and RestAssured frameworks — currently at CCtech, previously Mphasis.</p>
        <div style={s.heroBtns}>
          <a href="#" style={s.btnPrimary} onMouseEnter={e=>e.currentTarget.style.transform="translateY(-2px)"} onMouseLeave={e=>e.currentTarget.style.transform="none"}>⬇ Download Resume</a>
          <a href="#projects" style={s.btnOutline} onClick={e=>{e.preventDefault();scrollTo("projects")}}
            onMouseEnter={e=>{e.currentTarget.style.borderColor="#00D4FF";e.currentTarget.style.color="#00D4FF"}}
            onMouseLeave={e=>{e.currentTarget.style.borderColor="rgba(0,212,255,0.12)";e.currentTarget.style.color="#E8EDF5"}}>◈ View Projects</a>
          <a href="#contact" style={s.btnOutline} onClick={e=>{e.preventDefault();scrollTo("contact")}}
            onMouseEnter={e=>{e.currentTarget.style.borderColor="#00D4FF";e.currentTarget.style.color="#00D4FF"}}
            onMouseLeave={e=>{e.currentTarget.style.borderColor="rgba(0,212,255,0.12)";e.currentTarget.style.color="#E8EDF5"}}>✉ Contact Me</a>
        </div>
      </div>
      <div style={s.terminal}>
        <div style={s.termBar}>
          {[["#FF5F57"],["#FFBD2E"],["#28CA41"]].map(([c],i)=><span key={i} style={{width:10,height:10,borderRadius:"50%",background:c}}/>)}
          <span style={{fontFamily:"'JetBrains Mono',monospace",fontSize:"0.7rem",color:"#6B7A99",marginLeft:8}}>avinash@dev:~</span>
        </div>
        <div style={s.termBody}>
          {[
            <><span style={{color:"#00FF88"}}>➜</span> <span style={{color:"#00D4FF"}}>python</span> avinash.py</>,
            <span style={{color:"#6B7A99"}}>Loading profile...</span>,
            <span style={{color:"#FFD60A"}}>✔ Selenium WebDriver (Java) — 4+ yrs</span>,
            <span style={{color:"#FFD60A"}}>✔ RestAssured + TestNG — active</span>,
            <span style={{color:"#FFD60A"}}>✔ Cucumber BDD — running</span>,
            <span style={{color:"#FFD60A"}}>✔ Python + PyTest — learning</span>,
            <span style={{color:"#6B7A99"}}>🏢 CCtech · ex-Mphasis</span>,
            <span style={{color:"#6B7A99"}}>📍 Latur, Maharashtra</span>,
            <><span style={{color:"#00FF88"}}>➜</span> <span style={{display:"inline-block",width:8,height:14,background:"#00D4FF",verticalAlign:"middle",animation:"blink 1s infinite"}}/></>,
          ].map((line,i) => <span key={i} style={{display:"block"}}>{line}</span>)}
        </div>
      </div>
    </section>
  );
}

function SectionHeader({ num, id, title, sub }) {
  return (
    <div style={{marginBottom:60}}>
      <div className="reveal" style={s.secLabel}>{num}</div>
      <h2 className="reveal" style={s.secTitle}>{title}</h2>
      {sub && <p className="reveal" style={s.secSub}>{sub}</p>}
    </div>
  );
}

function About() {
  const journey = [
    {icon:"🎓", h:"B.E. — Pune University (2021)",  p:"CGPA 7.6 · SSC 90% · Strong academic foundation"},
    {icon:"🏢", h:"Mphasis Limited (Dec 2021 – Aug 2025)", p:"Software Engineer · Selenium + RestAssured · 80% automation coverage"},
    {icon:"🏆", h:"Awards at Mphasis",              p:"Employee of the Month · Laurel Award – Best Performer in Testing"},
    {icon:"🚀", h:"CCtech (Dec 2025 – Present)",    p:"QA Automation Engineer · Recap & InfraWorks · Python + PyTest"},
    {icon:"🤖", h:"Exploring AI & Python",          p:"Growing PyTest skills · Playwright POC · AI-powered testing tools"},
  ];
  return (
    <section style={{...s.section,background:"#0D1528",borderTop:"1px solid rgba(0,212,255,0.12)",borderBottom:"1px solid rgba(0,212,255,0.12)"}} id="about">
      <SectionHeader num="01 — About" title="My Journey"/>
      <div style={{display:"grid",gridTemplateColumns:"1fr 1fr",gap:80}}>
        <div className="reveal">
          {[
            <>Hey! I'm <strong style={{color:"#00D4FF"}}>Avinash Aade</strong>, a QA Automation Engineer based in <strong style={{color:"#00D4FF"}}>Latur, Maharashtra</strong> with <strong style={{color:"#00D4FF"}}>4+ years of experience</strong> in web, API, and mobile testing. Currently contributing to test automation at <strong style={{color:"#00D4FF"}}>CCtech</strong>, previously a Software Engineer at Mphasis Limited.</>,
            <>I specialize in <span style={{color:"#FF6B35",fontWeight:600}}>Selenium (Java) and RestAssured</span> frameworks — building hybrid automation solutions, implementing Page Object Model, and integrating CI/CD pipelines with Jenkins. I've increased automation coverage by 80% at Mphasis and mentored junior QA engineers on best practices.</>,
            <>I'm also growing my <strong style={{color:"#00D4FF"}}>Python + PyTest</strong> skills actively, exploring BDD with Cucumber, and staying current with modern tools like Playwright. I hold a <strong style={{color:"#00D4FF"}}>B.E. from Savitribai Phule Pune University</strong> and have been recognized as Employee of the Month and Laurel Award winner at Mphasis.</>,
          ].map((p,i) => <p key={i} style={{fontSize:"1rem",lineHeight:1.9,opacity:0.8,marginBottom:20}}>{p}</p>)}
          <div style={{marginTop:32,padding:24,background:"rgba(0,212,255,0.05)",border:"1px solid rgba(0,212,255,0.2)",borderLeft:"3px solid #00D4FF"}}>
            <p style={{fontSize:"0.92rem",lineHeight:1.7,opacity:0.85}}>🎯 <strong style={{color:"#00D4FF"}}>Goal:</strong> To become a strong Automation Engineer and contribute to scalable testing frameworks in product companies — writing clean, maintainable automation code that makes QA teams more effective.</p>
          </div>
        </div>
        <div className="reveal">
          {journey.map((j,i) => (
            <div key={i} style={{display:"flex",gap:20,padding:"20px 0",borderBottom: i<journey.length-1?"1px solid rgba(0,212,255,0.12)":"none"}}>
              <span style={{fontSize:"1.4rem",flexShrink:0,width:32}}>{j.icon}</span>
              <div><h4 style={{fontWeight:600,fontSize:"0.95rem",marginBottom:4}}>{j.h}</h4><p style={{fontSize:"0.85rem",color:"#6B7A99"}}>{j.p}</p></div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}

function Skills() {
  return (
    <section style={s.section} id="skills">
      <SectionHeader num="02 — Skills" title="Tech Stack" sub="The tools and technologies I work with every day."/>
      <div style={{display:"grid",gridTemplateColumns:"repeat(4,1fr)",gap:24}}>
        {SKILLS.map((g,i) => (
          <div key={i} className="reveal" style={{transitionDelay:`${i*0.1}s`,background:"rgba(255,255,255,0.03)",border:"1px solid rgba(0,212,255,0.12)",padding:"28px 24px",transition:"border-color 0.3s, transform 0.3s"}}
            onMouseEnter={e=>{e.currentTarget.style.borderColor=g.color;e.currentTarget.style.transform="translateY(-4px)"}}
            onMouseLeave={e=>{e.currentTarget.style.borderColor="rgba(0,212,255,0.12)";e.currentTarget.style.transform="none"}}>
            <div style={{fontFamily:"'JetBrains Mono',monospace",fontSize:"0.7rem",letterSpacing:"0.2em",textTransform:"uppercase",color:g.color,marginBottom:20,paddingBottom:12,borderBottom:"1px solid rgba(0,212,255,0.12)"}}>{g.label}</div>
            {g.items.map(item => <span key={item} style={{display:"inline-block",padding:"6px 12px",background:"rgba(255,255,255,0.04)",border:"1px solid rgba(255,255,255,0.08)",fontSize:"0.8rem",borderRadius:3,margin:"4px 4px 4px 0",color:"#E8EDF5"}}>{item}</span>)}
          </div>
        ))}
      </div>
    </section>
  );
}

function Experience() {
  return (
    <section style={{...s.section,background:"#0D1528",borderTop:"1px solid rgba(0,212,255,0.12)",borderBottom:"1px solid rgba(0,212,255,0.12)"}} id="experience">
      <SectionHeader num="03 — Experience" title="Work History"/>
      <div style={{display:"flex",flexDirection:"column",gap:2}}>
        {EXPERIENCE.map((exp,i) => (
          <div key={i} className="reveal" style={{background:"#111D35",padding:"36px 40px",borderLeft:`3px solid ${exp.color}`}}>
            <div style={{display:"flex",justifyContent:"space-between",alignItems:"flex-start",flexWrap:"wrap",gap:12,marginBottom:20}}>
              <div>
                <h3 style={{fontWeight:700,fontSize:"1.2rem"}}>{exp.role}</h3>
                <p style={{color:exp.color,fontFamily:"'JetBrains Mono',monospace",fontSize:"0.82rem",marginTop:4}}>{exp.company}</p>
              </div>
              <span style={{fontFamily:"'JetBrains Mono',monospace",fontSize:"0.72rem",color:"#6B7A99",background:`rgba(${exp.color=="#00D4FF"?"0,212,255":"0,255,136"},0.07)`,border:`1px solid rgba(${exp.color=="#00D4FF"?"0,212,255":"0,255,136"},0.15)`,padding:"6px 14px"}}>{exp.period}</span>
            </div>
            <ul style={{listStyle:"none",display:"flex",flexDirection:"column",gap:10}}>
              {exp.bullets.map((b,j) => <li key={j} style={{fontSize:"0.88rem",opacity:0.8,display:"flex",gap:10}}><span style={{color:exp.color,flexShrink:0}}>▸</span><span dangerouslySetInnerHTML={{__html:b.replace("80%","<strong style='color:#FFD60A'>80%</strong>")}}/></li>)}
            </ul>
            {exp.awards.length > 0 && (
              <div style={{display:"flex",gap:12,flexWrap:"wrap",marginTop:24}}>
                {exp.awards.map(a => <span key={a} style={{background:"rgba(255,214,10,0.1)",border:"1px solid rgba(255,214,10,0.3)",color:"#FFD60A",fontSize:"0.72rem",padding:"5px 12px",fontFamily:"'JetBrains Mono',monospace"}}>{a}</span>)}
              </div>
            )}
          </div>
        ))}
      </div>
    </section>
  );
}

function Projects() {
  return (
    <section style={{...s.section,background:"#0D1528"}} id="projects">
      <SectionHeader num="04 — Projects" title="What I've Built"/>
      <div style={{display:"grid",gridTemplateColumns:"repeat(3,1fr)",gap:2}}>
        {PROJECTS.map((p,i) => (
          <div key={i} className="reveal" style={{transitionDelay:`${(i%3)*0.1}s`,background:"#111D35",padding:"36px 28px",position:"relative",overflow:"hidden",transition:"transform 0.3s",border: p.future?"1px dashed rgba(0,212,255,0.2)":"none"}}
            onMouseEnter={e=>e.currentTarget.style.transform="translateY(-4px)"}
            onMouseLeave={e=>e.currentTarget.style.transform="none"}>
            <div style={{fontFamily:"'JetBrains Mono',monospace",fontSize:"0.65rem",letterSpacing:"0.2em",color:"#6B7A99",marginBottom:16}}>PROJECT {p.num}{p.future?" — UPCOMING":` · ${p.client}`}</div>
            <h3 style={{fontWeight:700,fontSize:"1.1rem",color: p.future?"#00D4FF":"#E8EDF5",marginBottom:10}}>{p.title}</h3>
            <div style={{fontFamily:"'JetBrains Mono',monospace",fontSize:"0.7rem",color:p.color,marginBottom:14,letterSpacing:"0.05em"}}>{p.tech}</div>
            <p style={{fontSize:"0.87rem",color:"#6B7A99",lineHeight:1.7,marginBottom:20}}>{p.desc}</p>
            <ul style={{listStyle:"none"}}>
              {p.features.map(f => <li key={f} style={{fontSize:"0.8rem",color:"#6B7A99",padding:"4px 0",display:"flex",alignItems:"center",gap:8}}><span style={{color:p.color,fontSize:"0.65rem"}}>▸</span>{f}</li>)}
            </ul>
          </div>
        ))}
      </div>
    </section>
  );
}

function Teaching() {
  const stats = [["1–10","#00D4FF","Grade Levels"],["3+","#00FF88","Subjects"],["MH","#FF6B35","State Board"],["📍","#FFD60A","Latur / Online"]];
  return (
    <section style={{...s.section,background:"#0D1528",borderTop:"1px solid rgba(0,212,255,0.12)",borderBottom:"1px solid rgba(0,212,255,0.12)"}} id="teaching">
      <SectionHeader num="05 — Teaching" title="Teaching & Mentoring" sub="Helping students build strong fundamentals in Math and Programming."/>
      <div style={{display:"grid",gridTemplateColumns:"1fr 1fr",gap:60,alignItems:"start"}}>
        <div className="reveal" style={{background:"rgba(255,255,255,0.03)",border:"1px solid rgba(0,212,255,0.12)",padding:36}}>
          <div style={{fontSize:"2.5rem",marginBottom:20}}>📖</div>
          <h3 style={{fontWeight:700,fontSize:"1.2rem",marginBottom:8}}>What I Teach</h3>
          <p style={{fontSize:"0.85rem",color:"#6B7A99",marginBottom:24}}>Maharashtra State Board · Latur & Online</p>
          <ul style={{listStyle:"none"}}>
            {["Mathematics (1st – 10th)","Basic Programming Concepts","Computer Fundamentals","Problem Solving Techniques","Algorithm Thinking for Beginners"].map((item,i,arr) => (
              <li key={item} style={{display:"flex",alignItems:"center",gap:10,padding:"8px 0",borderBottom: i<arr.length-1?"1px solid rgba(0,212,255,0.12)":"none",fontSize:"0.87rem",opacity:0.8}}>
                <span style={{color:"#FF6B35",fontSize:"0.75rem"}}>→</span>{item}
              </li>
            ))}
          </ul>
        </div>
        <div className="reveal" style={{display:"grid",gridTemplateColumns:"1fr 1fr",gap:16}}>
          {stats.map(([num,color,label]) => (
            <div key={label} style={{background:"#111D35",border:"1px solid rgba(0,212,255,0.12)",padding:"24px 20px",textAlign:"center"}}>
              <span style={{fontFamily:"'Outfit',sans-serif",fontWeight:800,fontSize:"2rem",color,display:"block",marginBottom:4}}>{num}</span>
              <span style={{fontSize:"0.75rem",color:"#6B7A99",letterSpacing:"0.1em",textTransform:"uppercase"}}>{label}</span>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}

function Blog() {
  return (
    <section style={s.section} id="blog">
      <SectionHeader num="06 — Blog" title="Technical Writing" sub="Sharing what I learn about automation, Python, and testing."/>
      <div style={{display:"grid",gridTemplateColumns:"repeat(3,1fr)",gap:24}}>
        {BLOG_POSTS.map((b,i) => (
          <div key={i} className="reveal" style={{transitionDelay:`${i*0.1}s`,background:"rgba(255,255,255,0.03)",border:"1px solid rgba(0,212,255,0.12)",padding:28,transition:"border-color 0.3s, transform 0.3s"}}
            onMouseEnter={e=>{e.currentTarget.style.borderColor=b.color;e.currentTarget.style.transform="translateY(-4px)"}}
            onMouseLeave={e=>{e.currentTarget.style.borderColor="rgba(0,212,255,0.12)";e.currentTarget.style.transform="none"}}>
            <span style={{fontFamily:"'JetBrains Mono',monospace",fontSize:"0.65rem",letterSpacing:"0.15em",textTransform:"uppercase",color:b.color,marginBottom:14,display:"inline-block"}}>{b.tag}</span>
            <h3 style={{fontWeight:600,fontSize:"1rem",marginBottom:10,lineHeight:1.4}}>{b.title}</h3>
            <p style={{fontSize:"0.83rem",color:"#6B7A99",lineHeight:1.7,marginBottom:20}}>{b.excerpt}</p>
            <span style={{fontSize:"0.75rem",color:b.color,letterSpacing:"0.1em"}}>Coming soon →</span>
          </div>
        ))}
      </div>
    </section>
  );
}

function Notes() {
  return (
    <section style={{...s.section,background:"#0D1528"}} id="notes">
      <SectionHeader num="07 — Notes" title="Automation Testing Notes" sub="Quick reference for Selenium, PyTest & interview prep — for me and for you."/>
      <div style={{display:"grid",gridTemplateColumns:"1fr 1fr",gap:24}}>
        {NOTES.map((n,i) => (
          <div key={i} className="reveal" style={{transitionDelay:`${(i%2)*0.1}s`,background:"#111D35",border:"1px solid rgba(0,212,255,0.12)",borderRadius:4,overflow:"hidden"}}>
            <div style={{padding:"16px 20px",background:"rgba(0,212,255,0.05)",borderBottom:"1px solid rgba(0,212,255,0.12)"}}>
              <h4 style={{fontFamily:"'JetBrains Mono',monospace",fontSize:"0.8rem",color:"#00D4FF"}}>{n.title}</h4>
            </div>
            <div style={{padding:20}}>
              {n.items.map(([cmd,desc]) => (
                <div key={cmd} style={{display:"flex",justifyContent:"space-between",alignItems:"flex-start",padding:"8px 0",borderBottom:"1px solid rgba(255,255,255,0.04)",gap:16}}>
                  <span style={{fontFamily:"'JetBrains Mono',monospace",fontSize:"0.75rem",color:"#00FF88",flexShrink:0}}>{cmd}</span>
                  <span style={{fontSize:"0.78rem",color:"#6B7A99",textAlign:"right"}}>{desc}</span>
                </div>
              ))}
            </div>
          </div>
        ))}
      </div>
    </section>
  );
}

function Contact() {
  return (
    <section style={{...s.section,textAlign:"center",position:"relative",overflow:"hidden"}} id="contact">
      <div style={{position:"absolute",inset:0,background:"radial-gradient(ellipse at 50% 100%, rgba(0,212,255,0.07) 0%, transparent 65%)",pointerEvents:"none"}}/>
      <div className="reveal" style={{...s.secLabel,textAlign:"center"}}>08 — Contact</div>
      <h2 className="reveal" style={{...s.secTitle,textAlign:"center"}}>Let's Connect</h2>
      <p className="reveal" style={{...s.secSub,margin:"0 auto",textAlign:"center"}}>Open to QA roles, freelance projects, and collabs.</p>
      <div className="reveal" style={{display:"flex",justifyContent:"center",flexWrap:"wrap",gap:20,marginTop:48}}>
        {CONTACT_LINKS.map(c => (
          <a key={c.label} href={c.href} target={c.href.startsWith("http")?"_blank":undefined}
            style={{background:"#111D35",border:"1px solid rgba(0,212,255,0.12)",padding:"24px 32px",display:"flex",alignItems:"center",gap:14,textDecoration:"none",color:"#E8EDF5",transition:"border-color 0.3s, transform 0.3s, background 0.3s",minWidth:220,borderRadius:4}}
            onMouseEnter={e=>{e.currentTarget.style.borderColor="#00D4FF";e.currentTarget.style.transform="translateY(-4px)";e.currentTarget.style.background="rgba(0,212,255,0.06)"}}
            onMouseLeave={e=>{e.currentTarget.style.borderColor="rgba(0,212,255,0.12)";e.currentTarget.style.transform="none";e.currentTarget.style.background="#111D35"}}>
            <span style={{fontSize:"1.8rem",flexShrink:0}}>{c.icon}</span>
            <div>
              <div style={{fontSize:"0.7rem",color:"#6B7A99",letterSpacing:"0.1em",textTransform:"uppercase",marginBottom:4}}>{c.label}</div>
              <div style={{fontWeight:600,fontSize:"0.9rem",color:"#00D4FF",wordBreak:"break-all"}}>{c.value}</div>
            </div>
          </a>
        ))}
      </div>
    </section>
  );
}

function Footer() {
  return (
    <footer style={{padding:"32px 60px",display:"flex",justifyContent:"space-between",alignItems:"center",borderTop:"1px solid rgba(0,212,255,0.12)",fontFamily:"'JetBrains Mono',monospace",fontSize:"0.72rem",color:"#6B7A99"}}>
      <span>© 2026 Avinash Aade</span>
      <span>Built with Python mindset ✦ Automation first</span>
    </footer>
  );
}

// ── APP ───────────────────────────────────────────────────────────────────────

export default function App() {
  useReveal();
  return (
    <>
      <style>{G}</style>
      <Nav />
      <Hero />
      <About />
      <Skills />
      <Experience />
      <Projects />
      <Teaching />
      <Blog />
      <Notes />
      <Contact />
      <Footer />
    </>
  );
}
