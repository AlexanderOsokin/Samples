using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using RndBook.DataModel;

namespace RndBook.ViewModels
{
    public class ContactsViewModel : BaseViewModel
    {
        public IDataSource<IContactItem> DataSource { get; set; }
        public List<IContactItem> Contacts { get; private set; }

        int _currentPage = 0;

        public ContactsViewModel()
        {
            Title = "Contacts list";
            Contacts = new List<IContactItem>();
        }


        public async Task LoadMode(bool forced=false)
        {
            if (IsBusy)
                return;

            IsBusy = true;

            try
            {
                if (forced)
                    _currentPage = 0;
                
                var items = await DataSource.GetItemsAsync(_currentPage);
                if (items != null)
                     Contacts.AddRange(items);

            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex);
            }
            finally
            {
                IsBusy = false;
            }
        }

    }
}
