import { Calendar, Clock, Tag } from 'lucide-react';
import type { Blog } from '../lib/supabase';

interface BlogCardProps {
  blog: Blog;
  onClick: () => void;
}

export default function BlogCard({ blog, onClick }: BlogCardProps) {
  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
    });
  };

  return (
    <article
      onClick={onClick}
      className="bg-white rounded-2xl overflow-hidden hover:shadow-2xl transition-all duration-500 cursor-pointer group"
    >
      <div className="relative h-56 overflow-hidden">
        <img
          src={blog.image_url}
          alt={blog.title}
          className="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
        />
        <div className="absolute top-4 left-4">
          <span className="px-4 py-1 bg-slate-900/80 backdrop-blur-sm text-white text-sm rounded-full">
            {blog.category}
          </span>
        </div>
      </div>

      <div className="p-6">
        <h3 className="text-2xl font-bold text-slate-900 mb-3 group-hover:text-slate-700 transition-colors">
          {blog.title}
        </h3>

        <p className="text-slate-600 mb-4 line-clamp-2 leading-relaxed">
          {blog.excerpt}
        </p>

        <div className="flex flex-wrap items-center gap-4 text-sm text-slate-500 mb-4">
          <div className="flex items-center gap-1">
            <Calendar className="w-4 h-4" />
            <span>{formatDate(blog.published_date)}</span>
          </div>
          <div className="flex items-center gap-1">
            <Clock className="w-4 h-4" />
            <span>{blog.read_time} min read</span>
          </div>
        </div>

        {blog.tags.length > 0 && (
          <div className="flex flex-wrap gap-2">
            {blog.tags.slice(0, 3).map((tag) => (
              <span
                key={tag}
                className="flex items-center gap-1 px-3 py-1 bg-slate-100 text-slate-600 text-xs rounded-full"
              >
                <Tag className="w-3 h-3" />
                {tag}
              </span>
            ))}
          </div>
        )}
      </div>
    </article>
  );
}
