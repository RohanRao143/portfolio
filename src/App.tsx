import react, { useState } from 'react'
import Navigation from './components/Navigation';
import Hero from './components/Hero';
import Summary from './components/Summary';
import Skills from './components/Skills';
import Projects from './components/Projects';
import Blogs from './components/Blogs';
import Footer from './components/Footer';

function App() {
  const [count, setCount] = useState(0)
  
  return (
    <div className="min-h-screen">
      <Navigation />
      <Hero />
      <Summary />
      <Skills />
      <Projects />
      <Blogs />
      <Footer />
    </div>
  );
}

export default App;
