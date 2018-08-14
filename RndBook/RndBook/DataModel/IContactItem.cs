using System;
namespace RndBook.DataModel
{
    public interface IContactItem
    {
        string FirstName { get; set; }
        string LastName { get; set; }
        string MiddleName { get; set; }
        string Phone { get; set; }
        string Mail { get; set; }
        string ImageUrl { get; set; }
    }
}
