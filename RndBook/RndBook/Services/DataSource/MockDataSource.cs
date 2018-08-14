using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RndBook.DataModel.Models;

namespace RndBook.Services.DataSource
{
    public class MockDataSource : IDataSource<ContactItem>
    {
        List<ContactItem> _items;

        public MockDataSource()
        {
            _items = new List<ContactItem>
            {
                new ContactItem { 
                    FirstName = "Ivan",
                    LastName = "Ivanov", 
                    MiddleName ="Ivanovich", 
                    ImageUrl="", 
                    Mail = "ivan@gmail.com",
                    Phone ="+71234567890"},
                
                new ContactItem {
                    FirstName = "Oleg",
                    LastName = "Olegov",
                    MiddleName ="Olegovich",
                    ImageUrl="",
                    Mail = "oleg@gmail.com",
                    Phone ="+71234567890"},

            };
        }

        public async Task<IEnumerable<ContactItem>> GetItemsAsync(int page)
        {
            return await Task.FromResult(_items);
        }
    }
}
