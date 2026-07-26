import DashboardLayout from "@/components/DashboardLayout";
import { useAuth } from "@/_core/hooks/useAuth";
import { trpc } from "@/lib/trpc";
import { Link, Route, Switch, useLocation } from "wouter";
import OverviewPage from "./dashboard/Overview";
import OffersPage from "./dashboard/Offers";
import RequestsPage from "./dashboard/Requests";
import EntitiesPage from "./dashboard/Entities";
import DrugsPage from "./dashboard/Drugs";
import MessagesPage from "./dashboard/Messages";
import NotificationsPage from "./dashboard/Notifications";
import IntelligencePage from "./dashboard/Intelligence";
import AlternativesPage from "./dashboard/Alternatives";
import ProfilePage from "./dashboard/Profile";
import MatchesPage from "./dashboard/Matches";
import RegisterPage from "./dashboard/Register";
import { startLogin } from "@/const";
import { Button } from "@/components/ui/button";

function DashboardRouter() {
  const { user, isAuthenticated, loading } = useAuth();
  const [location, setLocation] = useLocation();

  if (loading) {
    return <div className="flex items-center justify-center h-full"><span>Loading...</span></div>;
  }

  if (!isAuthenticated) {
    return (
      <div className="flex items-center justify-center min-h-[60vh]">
        <Button onClick={() => startLogin()}>Sign In</Button>
      </div>
    );
  }

  const isAdmin = user?.role === "admin";

  return (
    <DashboardLayout>
      <Switch>
        <Route path="/dashboard" component={OverviewPage} />
        <Route path="/dashboard/overview" component={OverviewPage} />
        <Route path="/dashboard/offers" component={OffersPage} />
        <Route path="/dashboard/requests" component={RequestsPage} />
        <Route path="/dashboard/drugs" component={DrugsPage} />
        <Route path="/dashboard/messages" component={MessagesPage} />
        <Route path="/dashboard/notifications" component={NotificationsPage} />
        {isAdmin && <Route path="/dashboard/entities" component={EntitiesPage} />}
        {isAdmin && <Route path="/dashboard/intelligence" component={IntelligencePage} />}
        {isAdmin && <Route path="/dashboard/alternatives" component={AlternativesPage} />}
        <Route path="/dashboard/profile" component={ProfilePage} />
        <Route path="/dashboard/matches" component={MatchesPage} />
        <Route path="/dashboard/register" component={RegisterPage} />
      </Switch>
    </DashboardLayout>
  );
}

export default function Dashboard() {
  return <DashboardRouter />;
}
