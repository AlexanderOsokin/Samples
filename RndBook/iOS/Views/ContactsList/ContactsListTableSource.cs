using System;
using Foundation;
using RndBook.ViewModels;
using UIKit;

namespace RndBook.iOS
{
    public class ContactsListTableSource: UITableViewSource
    {
        static readonly NSString CELL_IDENTIFIER = new NSString("ITEM_CELL");

        ContactsViewModel _viewModel;

        public ContactsListTableSource(ContactsViewModel viewModel)
        {
            _viewModel = viewModel;
        }

        public override nint RowsInSection(UITableView tableview, nint section) => _viewModel.Contacts.Count;
        public override nint NumberOfSections(UITableView tableView) => 1;

        public override UITableViewCell GetCell(UITableView tableView, NSIndexPath indexPath)
        {
            var cell = tableView.DequeueReusableCell(CELL_IDENTIFIER, indexPath);

            var item = _viewModel.Contacts[indexPath.Row];
            cell.TextLabel.Text = item.FirstName;
            cell.DetailTextLabel.Text = item.LastName;
            cell.LayoutMargins = UIEdgeInsets.Zero;
            return cell;
        }
    }


}
