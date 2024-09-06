using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Language.Discovery.Repository
{
    public interface IRepository<T>
    {
        object Add(T tObject );
        bool Update(T tObject);
        bool Delete(T tObject);
        T GetByID(Int64 id);
    }
}
