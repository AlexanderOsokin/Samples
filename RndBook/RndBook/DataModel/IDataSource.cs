using System.Collections.Generic;
using System.Threading.Tasks;

namespace RndBook
{
    public interface IDataSource<T>
    {
        Task<IEnumerable<T>> GetItemsAsync(int page);
    }
}
