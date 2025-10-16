import { X, Calendar, Clock, User, Tag } from 'lucide-react';
import type { Blog } from '../lib/supabase';

interface BlogModalProps {
  blog: Blog;
  onClose: () => void;
}

export default function BlogModal({ blog, onClose }: BlogModalProps) {
  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
    });
  };

  return (
    <div className="fixed inset-0 z-50 overflow-y-auto bg-slate-900/50 backdrop-blur-sm">
      <div className="min-h-screen px-4 flex items-center justify-center">
        <div className="bg-white rounded-3xl max-w-4xl w-full shadow-2xl animate-fadeIn">
          <div className="relative h-72 rounded-t-3xl overflow-hidden">
            <img
              src={blog.image_url}
              alt={blog.title}
              className="w-full h-full object-cover"
            />
            <button
              onClick={onClose}
              className="absolute top-4 right-4 p-2 bg-white/90 hover:bg-white rounded-full transition-colors"
              aria-label="Close modal"
            >
              <X className="w-6 h-6 text-slate-900" />
            </button>
            <div className="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-slate-900/90 to-transparent p-8">
              <span className="inline-block px-4 py-1 bg-white/20 backdrop-blur-sm text-white text-sm rounded-full mb-4">
                {blog.category}
              </span>
              <h2 className="text-4xl font-bold text-white">{blog.title}</h2>
            </div>
          </div>

          <div className="p-8">
            <div className="flex flex-wrap items-center gap-6 text-sm text-slate-600 mb-6 pb-6 border-b border-slate-200">
              <div className="flex items-center gap-2">
                <User className="w-4 h-4" />
                <span>{blog.author}</span>
              </div>
              <div className="flex items-center gap-2">
                <Calendar className="w-4 h-4" />
                <span>{formatDate(blog.published_date)}</span>
              </div>
              <div className="flex items-center gap-2">
                <Clock className="w-4 h-4" />
                <span>{blog.read_time} min read</span>
              </div>
            </div>

            <div className="prose prose-slate max-w-none mb-6">
              <p className="text-xl text-slate-700 leading-relaxed mb-6">
                {blog.excerpt}
              </p>
              <div className="text-slate-600 leading-relaxed whitespace-pre-line">
                {blog.content}
              </div>
            </div>

            {blog.tags.length > 0 && (
              <div className="flex flex-wrap gap-2 pt-6 border-t border-slate-200">
                {blog.tags.map((tag) => (
                  <span
                    key={tag}
                    className="flex items-center gap-1 px-4 py-2 bg-slate-100 text-slate-700 text-sm rounded-full"
                  >
                    <Tag className="w-3 h-3" />
                    {tag}
                  </span>
                ))}
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
