import { Code2, Rocket, Users, Award } from 'lucide-react';

export default function Summary() {
  const stats = [
    { icon: Code2, label: 'Years Experience', value: '6+' },
    { icon: Rocket, label: 'Professional/Personal Projects Contributed', value: '10+/15+' },
    { icon: Users, label: 'Work Clients', value: '30+' },
    { icon: Award, label: 'Certifications or Endorsements', value: '5+' },
  ];

  return (
    <section id="about" className="py-20 bg-white">
      <div className="container mx-auto px-6">
        <div className="max-w-6xl mx-auto">
          <h2 className="text-4xl md:text-5xl font-bold text-slate-900 mb-16 text-center">
            About Me
          </h2>

          <div className="grid md:grid-cols-2 gap-12 items-center mb-16">
            <div>
              <p className="text-lg text-slate-600 leading-relaxed mb-6">
                I'm a passionate software engineer with a focus on building scalable web applications
                and creating exceptional user experiences. With expertise in modern JavaScript frameworks
                and full-stack development, I transform ideas into robust digital solutions.
              </p>
              <p className="text-lg text-slate-600 leading-relaxed mb-6">
                My journey in software development has been driven by curiosity and a commitment to
                continuous learning. I thrive in collaborative environments where innovation meets
                practical problem-solving.
              </p>
              <p className="text-lg text-slate-600 leading-relaxed">
                When I'm not coding, you'll find me exploring new technologies, contributing to
                open-source projects, or sharing knowledge with the developer community.
              </p>
            </div>

            <div className="grid grid-cols-2 gap-6">
              {stats.map((stat) => (
                <div
                  key={stat.label}
                  className="bg-gradient-to-br from-slate-50 to-slate-100 p-6 rounded-2xl text-center hover:shadow-lg transition-all duration-300 hover:-translate-y-1"
                >
                  <stat.icon className="w-8 h-8 text-slate-700 mx-auto mb-3" />
                  <div className="text-3xl font-bold text-slate-900 mb-1">
                    {stat.value}
                  </div>
                  <div className="text-sm text-slate-600">{stat.label}</div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
