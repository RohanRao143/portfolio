/*
  # Portfolio Website Schema

  1. New Tables
    - `blogs`
      - `id` (uuid, primary key) - Unique identifier for each blog post
      - `title` (text) - Blog post title
      - `excerpt` (text) - Short description/preview
      - `content` (text) - Full blog post content
      - `author` (text) - Author name
      - `category` (text) - Blog category (e.g., "Tech News", "Tutorial")
      - `tags` (text[]) - Array of tags for filtering
      - `image_url` (text) - Featured image URL
      - `published_date` (timestamptz) - Publication date
      - `read_time` (integer) - Estimated reading time in minutes
      - `created_at` (timestamptz) - Record creation timestamp
      - `updated_at` (timestamptz) - Record update timestamp
    
    - `projects`
      - `id` (uuid, primary key) - Unique identifier for each project
      - `title` (text) - Project name
      - `description` (text) - Project description
      - `long_description` (text) - Detailed project information
      - `technologies` (text[]) - Array of technologies used
      - `image_url` (text) - Project screenshot/image
      - `demo_url` (text, nullable) - Live demo URL
      - `github_url` (text, nullable) - GitHub repository URL
      - `featured` (boolean) - Whether project is featured
      - `display_order` (integer) - Order for displaying projects
      - `created_at` (timestamptz) - Record creation timestamp
      - `updated_at` (timestamptz) - Record update timestamp

  2. Security
    - Enable RLS on both tables
    - Add policies for public read access (portfolio is public)
    - Only authenticated admin users can modify data

  3. Important Notes
    - Tables use sensible defaults for timestamps and booleans
    - Arrays are used for tags and technologies for flexible filtering
    - Public read access allows visitors to view portfolio content
    - Write operations are restricted to authenticated users only
*/

-- Create blogs table
CREATE TABLE IF NOT EXISTS blogs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  excerpt text NOT NULL,
  content text NOT NULL,
  author text NOT NULL DEFAULT 'Admin',
  category text NOT NULL DEFAULT 'Tech News',
  tags text[] DEFAULT '{}',
  image_url text NOT NULL,
  published_date timestamptz DEFAULT now(),
  read_time integer DEFAULT 5,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create projects table
CREATE TABLE IF NOT EXISTS projects (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  description text NOT NULL,
  long_description text NOT NULL,
  technologies text[] NOT NULL DEFAULT '{}',
  image_url text NOT NULL,
  demo_url text,
  github_url text,
  featured boolean DEFAULT false,
  display_order integer DEFAULT 0,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE blogs ENABLE ROW LEVEL SECURITY;
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;

-- Policies for blogs table
CREATE POLICY "Anyone can view blogs"
  ON blogs FOR SELECT
  TO anon, authenticated
  USING (true);

CREATE POLICY "Authenticated users can insert blogs"
  ON blogs FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Authenticated users can update blogs"
  ON blogs FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Authenticated users can delete blogs"
  ON blogs FOR DELETE
  TO authenticated
  USING (true);

-- Policies for projects table
CREATE POLICY "Anyone can view projects"
  ON projects FOR SELECT
  TO anon, authenticated
  USING (true);

CREATE POLICY "Authenticated users can insert projects"
  ON projects FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Authenticated users can update projects"
  ON projects FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Authenticated users can delete projects"
  ON projects FOR DELETE
  TO authenticated
  USING (true);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_blogs_published_date ON blogs(published_date DESC);
CREATE INDEX IF NOT EXISTS idx_blogs_category ON blogs(category);
CREATE INDEX IF NOT EXISTS idx_projects_featured ON projects(featured);
CREATE INDEX IF NOT EXISTS idx_projects_display_order ON projects(display_order);

-- Insert sample blog posts
INSERT INTO blogs (title, excerpt, content, author, category, tags, image_url, read_time) VALUES
('The Future of Web Development in 2025', 'Exploring emerging trends and technologies shaping the web development landscape.', 'The web development ecosystem continues to evolve at a rapid pace. In 2025, we''re seeing exciting developments in areas like edge computing, AI-powered development tools, and advanced framework capabilities. React Server Components are becoming mainstream, offering better performance and user experience. TypeScript adoption has reached new heights, with even more projects embracing type safety. The rise of AI assistants for coding is transforming how we write and debug code, making developers more productive than ever. WebAssembly is opening new possibilities for running high-performance applications in the browser. Meanwhile, the focus on web performance, accessibility, and sustainability continues to grow, with new tools and metrics helping developers build better experiences for all users.', 'Tech Insights', 'Tech News', ARRAY['Web Development', 'Technology', 'Trends'], 'https://images.pexels.com/photos/11035471/pexels-photo-11035471.jpeg', 7),
('Understanding Modern JavaScript Frameworks', 'A deep dive into React, Vue, and other popular frameworks driving modern web applications.', 'JavaScript frameworks have revolutionized how we build web applications. React remains a dominant force with its component-based architecture and vast ecosystem. Vue.js offers an approachable yet powerful alternative with excellent documentation. Each framework has its strengths: React excels in large-scale applications with complex state management, Vue provides an excellent developer experience with its intuitive API, and newer frameworks like Solid and Svelte push the boundaries of performance. Understanding the trade-offs and use cases for each framework helps developers make informed decisions. The key is choosing the right tool for your specific needs rather than following trends blindly. Modern frameworks share common concepts like reactivity, component composition, and declarative rendering, making it easier to switch between them.', 'Development Team', 'Tech News', ARRAY['JavaScript', 'React', 'Vue', 'Frameworks'], 'https://images.pexels.com/photos/270404/pexels-photo-270404.jpeg', 10),
('Building Scalable APIs with Node.js', 'Best practices and patterns for creating robust backend services that can handle growth.', 'Building scalable APIs requires careful consideration of architecture, performance, and maintainability. Node.js provides an excellent foundation with its non-blocking I/O and event-driven architecture. Key principles include proper error handling, input validation, rate limiting, and authentication. Using Express or Fastify as your framework provides a solid starting point. Implement middleware for cross-cutting concerns like logging, CORS, and security headers. Database connection pooling and caching strategies are crucial for performance. Consider using API versioning from the start to enable breaking changes without disrupting existing clients. Document your API thoroughly using tools like Swagger or OpenAPI. Implement comprehensive testing including unit tests, integration tests, and load testing. Monitor your APIs in production with proper logging and metrics. Finally, consider containerization with Docker and orchestration with Kubernetes for true scalability.', 'Backend Specialist', 'Tech News', ARRAY['Node.js', 'API', 'Backend', 'Scalability'], 'https://images.pexels.com/photos/1181671/pexels-photo-1181671.jpeg', 8);

-- Insert sample projects
INSERT INTO projects (title, description, long_description, technologies, image_url, demo_url, github_url, featured, display_order) VALUES
('E-Commerce Platform', 'Full-stack e-commerce solution with payment integration and admin dashboard', 'A comprehensive e-commerce platform built with modern web technologies. Features include user authentication, product catalog with search and filtering, shopping cart functionality, secure checkout with Stripe integration, order management, and a full-featured admin dashboard. The platform uses React for the frontend with TypeScript for type safety, Node.js and Express for the backend API, and PostgreSQL for data persistence. Implemented real-time inventory updates, email notifications, and responsive design for mobile shopping. The admin panel allows for product management, order processing, and analytics visualization.', ARRAY['React', 'TypeScript', 'Node.js', 'PostgreSQL', 'Stripe', 'Tailwind CSS'], 'https://images.pexels.com/photos/230544/pexels-photo-230544.jpeg', 'https://example.com/ecommerce', 'https://github.com/example/ecommerce', true, 1),
('Real-Time Chat Application', 'WebSocket-based messaging platform with rooms and file sharing', 'A modern real-time chat application that enables instant messaging between users. Built with React and Socket.io for real-time bidirectional communication. Features include user authentication, public and private chat rooms, direct messaging, typing indicators, online status, message history, and file sharing capabilities. The backend uses Node.js with Express and Socket.io, while messages are stored in MongoDB. Implemented message encryption for privacy, emoji support, and notification systems. The UI is responsive and works seamlessly across devices with a clean, modern interface built using Tailwind CSS.', ARRAY['React', 'Socket.io', 'Node.js', 'MongoDB', 'Express', 'Tailwind CSS'], 'https://images.pexels.com/photos/607812/pexels-photo-607812.jpeg', 'https://example.com/chat', 'https://github.com/example/chat', true, 2),
('Task Management Dashboard', 'Kanban-style project management tool with team collaboration features', 'A powerful task management application inspired by tools like Trello and Asana. Features drag-and-drop kanban boards, task cards with detailed descriptions, due dates, labels, and attachments. Users can create multiple projects, invite team members, assign tasks, and track progress. Built with React and TypeScript for a robust frontend experience, with beautiful animations using Framer Motion. The backend API is built with Node.js and uses PostgreSQL for data storage. Implemented real-time updates so team members see changes instantly. Includes notification system, search functionality, filtering options, and activity logs. Dark mode support and fully responsive design ensure great user experience across all devices.', ARRAY['React', 'TypeScript', 'PostgreSQL', 'Node.js', 'Framer Motion'], 'https://images.pexels.com/photos/3184292/pexels-photo-3184292.jpeg', 'https://example.com/taskmanager', 'https://github.com/example/taskmanager', true, 3),
('Weather Forecast App', 'Beautiful weather application with location-based forecasts and interactive maps', 'A sleek weather application that provides accurate weather forecasts using the OpenWeatherMap API. Features include current weather conditions, hourly and 7-day forecasts, location search, geolocation support, and interactive weather maps. Built with React and styled with Tailwind CSS for a modern, responsive design. Displays detailed information including temperature, humidity, wind speed, UV index, and more. Implements data caching to reduce API calls and improve performance. Beautiful weather animations and icons enhance the visual experience. Includes unit conversion (Celsius/Fahrenheit), favorite locations, and weather alerts.', ARRAY['React', 'OpenWeatherMap API', 'Tailwind CSS', 'JavaScript'], 'https://images.pexels.com/photos/1118873/pexels-photo-1118873.jpeg', 'https://example.com/weather', 'https://github.com/example/weather', false, 4);
