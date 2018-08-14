using System;
using RndBook.DataModel;

namespace RndBook.ViewModels
{
    public class ItemDetailViewModel : BaseViewModel
    {
        public IContactItem Item { get; private set; }
        public ItemDetailViewModel(IContactItem item = null)
        {
            if (item != null)
            {
                Title = $"{item.FirstName} {item.LastName}";
                Item = item;
            }
        }

    }
}
