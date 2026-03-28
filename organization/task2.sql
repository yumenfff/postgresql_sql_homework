with recursive
    subordinates as ( select e.EmployeeID, e.Name, e.ManagerID, e.DepartmentID, e.RoleID
                      from Employees e
                      where e.EmployeeID = 1

                      union all

                      select e.EmployeeID, e.Name, e.ManagerID, e.DepartmentID, e.RoleID
                      from Employees e
                               join subordinates s on e.ManagerID = s.EmployeeID ),
    employee_projects as ( select DepartmentID, string_agg(ProjectName, ', ' order by ProjectName) as ProjectNames
                           from Projects
                           group by DepartmentID ),
    employee_tasks as ( select AssignedTo,
                               string_agg(TaskName, ', ' order by TaskName) as TaskNames,
                               count(*)                                     as TotalTasks
                        from Tasks
                        group by AssignedTo ),
    direct_subordinates as ( select ManagerID, count(*) as TotalSubordinates
                             from Employees
                             where ManagerID is not null
                             group by ManagerID )
select s.EmployeeID,
       s.Name                            as EmployeeName,
       s.ManagerID,
       d.DepartmentName,
       r.RoleName,
       ep.ProjectNames,
       et.TaskNames,
       coalesce(et.TotalTasks, 0)        as TotalTasks,
       coalesce(ds.TotalSubordinates, 0) as TotalSubordinates
from subordinates s
         join Departments d on s.DepartmentID = d.DepartmentID
         join Roles r on s.RoleID = r.RoleID
         left join employee_projects ep on s.DepartmentID = ep.DepartmentID
         left join employee_tasks et on s.EmployeeID = et.AssignedTo
         left join direct_subordinates ds on s.EmployeeID = ds.ManagerID
order by s.Name;
